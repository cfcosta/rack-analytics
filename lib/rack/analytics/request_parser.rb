module Rack
  module Analytics
    class RequestParser
      attr_reader :data

      def initialize
      end
      
      def parse request
        @data = {}

        @data['time'] = Time.now

        return self
      end
    end
  end
end