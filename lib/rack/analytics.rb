module Rack
  module Analytics
    class Application
      DEFAULT_MASK = "analytics:#path#:#method#"

      def initialize app, options = {}, &block
        @app = app
        @options = options
      end

      def call env
        if env['REQUEST_METHOD'] == 'GET'
          key = DEFAULT_MASK.dup
          key['#path#'] = env['PATH_INFO']
          key['#method#'] = 'views'

          db.incr key
        end

        @app.call(env)
      end

      private
      def db
        @options[:redis] || Redis.new
      end
    end
  end
end
