$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__))

require 'rack/analytics/request_logger'
require 'rack/analytics/request_parser'

require 'active_support/core_ext/module/attribute_accessors'

module Rack
  module Analytics
    mattr_accessor :queue
    @@queue = Queue.new

    mattr_accessor :parser
    @@parser = RequestParser.new

    mattr_accessor :db_name
    @@db_name = 'rack-analytics'

    mattr_accessor :db
    @@db = Mongo::Connection.new.db(@@db_name)

    mattr_accessor :thread
    def self.thread
      @@thread = Thread.new do
        while env = @@queue.pop
          db[env['PATH_INFO']].insert parser.parse(env).data
        end
      end
    end
  end
end