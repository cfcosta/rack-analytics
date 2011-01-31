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

        return self
      end
    end
  end
end