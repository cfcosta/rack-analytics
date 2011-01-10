module Rack
  module Analytics
    class Application
      DEFAULT_MASK = "analytics:#path#:#method#"

      def initialize app, options = {}, &block
        @app = app
        @options = options
      end

      def call env
        @env = env

        set_statistics
        save_referal_information

        @app.call(env)
      end

      private
      def db
        @options[:redis] || Redis.new
      end

      def set_statistics
        if @env['REQUEST_METHOD'] == 'GET'
          db.incr generate_key(:views)
        end
      end

      def save_referal_information
        puts db.get(generate_key(:referers)).inspect
        db.set generate_key(:referers), {}.to_msgpack

        referers = MessagePack.unpack db.get(generate_key(:referers))
        referers[@env['HTTP_REFERER']] = (referers[@env['HTTP_REFERER']].to_i + 1).to_s
      end

      def generate_key method
        key = DEFAULT_MASK.dup
        key['#path#'] = @env['PATH_INFO']
        key['#method#'] = method.to_s

        key
      end
    end
  end
end
