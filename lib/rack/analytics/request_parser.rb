module Rack
  module Analytics
    class RequestParser
      attr_reader :data

      def initialize
      end
      
      def parse request
        @data = {}

        @data['time'] = Time.now
        @data['path'] = request['PATH_INFO']
        @data['user_agent'] = request['HTTP_USER_AGENT']

        return self
      end
    end
  end
end