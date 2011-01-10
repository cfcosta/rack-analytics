require 'rubygems'
require 'rspec'
require 'webrat'
require 'rack/test'
require 'msgpack'
require 'redis'

$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__))

require 'rack/analytics'

require 'spec/support/dummy_app'

RSpec.configure do |config|
  config.include Webrat::Matchers
  config.include Webrat::Methods
  config.include Rack::Test::Methods

  Webrat.configure do |c|
    c.mode = :rack
  end

  def app
    Rack::Builder.new do
      use Rack::Analytics::Application, :redis => db
      run DummyApp
    end
  end

  def db
    $redis ||= Redis.new
  end

  def namespace
    'analytics-test'
  end
end
