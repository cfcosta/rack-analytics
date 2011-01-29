module Rack
  module Analytics
    class RequestLogger
      def initialize app, options = {}
        @app = app
        @options = options
        @default_mask = "#{namespace}:#path#:#method#"
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

      def namespace
        @options[:namespace] || 'analytics'
      end

      def set_statistics
        if @env['REQUEST_METHOD'] == 'GET'
          db.incr generate_key(:views)
        end
      end

      def save_referal_information
        db.set generate_key(:referers), {}.to_msgpack if db.get(generate_key(:referers)) == nil

        referers = MessagePack.unpack db.get(generate_key(:referers))
        referers[@env['HTTP_REFERER']] = (referers[@env['HTTP_REFERER']].to_i + 1)

        db.set generate_key(:referers), referers.to_msgpack
      end

      def generate_key method
        key = @default_mask.dup
        key['#path#'] = @env['PATH_INFO']
        key['#method#'] = method.to_s

        key
      end
    end
  end
end
