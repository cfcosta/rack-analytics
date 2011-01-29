require 'rubygems'
require 'webrat'
require 'rack/test'
require 'riot'

$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__))

require 'test/support/dummy_app'

require 'rack/analytics'

include Webrat::Matchers
include Webrat::Methods
include Rack::Test::Methods

Webrat.configure do |c|
  c.mode = :rack
end

def app
  Rack::Builder.new do
    use Rack::Analytics::RequestLogger
    run DummyApp
  end
end

def db
  nil
end

def namespace
  'analytics-test'
end
