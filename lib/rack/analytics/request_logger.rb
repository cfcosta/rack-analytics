module Rack
  module Analytics
    class RequestLogger
      def initialize app, options = {}
        @app = app
        @options = options
      end

      def call env
        if env['REQUEST_METHOD'] == 'GET'
          db[env['PATH_INFO']].insert 'time' => Time.now
        end
        
        @app.call(env)
      end

      private
      def db
        @options[:db]
      end
    end
  end
end
