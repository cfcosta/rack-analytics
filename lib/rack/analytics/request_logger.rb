require "thread"

module Rack
  module Analytics
    class RequestLogger
      def initialize app, options = {}
        @app = app
        @options = options
      end

      def call env
        if env['REQUEST_METHOD'] == 'GET'
          queue << parser.parse(env).data

          Thread.new { db[env['PATH_INFO']].insert queue.pop }
        end

        @app.call(env)
      end

      private
      def db
        @options[:db] || Mongo::Connection.new.db(@options[:db_name])
      end
      
      def queue
        @options[:queue] ||= Queue.new
      end
      
      def parser
        @options[:parser] ||= RequestParser.new
      end
    end
  end
end
