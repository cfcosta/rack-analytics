module Rack
  module Analytics
    class RequestParser
      attr_reader :data

      DEFAULT_KEYS = ['time', 'path', 'user_agent']

      def initialize
      end

      def except=(values)
        @except = values.to_a
      end

      def only=(values)
        @only = values.to_a
      end

      def parse request
        @data = {}

        @data['time'] = Time.now if to_parse.include? 'time'
        @data['path'] = request['PATH_INFO'] if to_parse.include? 'path'
        @data['user_agent'] = request['HTTP_USER_AGENT'] if to_parse.include? 'user_agent'

        return self
      end

      private
      def to_parse
        @only ? @only.to_a : DEFAULT_KEYS - @except.to_a
      end
    end
  end
end