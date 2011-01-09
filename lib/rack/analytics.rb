module Rack
  module Analytics
    class Application
      def initialize app, options = {}, &block
        @app = app
        @options = options
      end

      def call env
        @app.call(env)
      end
    end
  end
end
