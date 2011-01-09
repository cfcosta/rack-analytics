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

      private
      def db
        @options[:redis] || Redis.new
      end
    end
  end
end
