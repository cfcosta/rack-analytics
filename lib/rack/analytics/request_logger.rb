require "thread"

module Rack
  module Analytics
    class RequestLogger
      def initialize app, options = {}
        @app = app
        @options = options
      end

      def call env
        Rack::Analytics.queue << env if env['REQUEST_METHOD'] == 'GET'

        @app.call(env)
      end
    end
  end
end
