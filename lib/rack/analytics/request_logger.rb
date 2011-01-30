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
          access = { 'time' => Time.now }
          access['referral'] = env['HTTP_REFERER'] if env['HTTP_REFERER']
          access['user_agent'] = env['HTTP_USER_AGENT'] if env['HTTP_USER_AGENT']

          queue << access

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
    end
  end
end
