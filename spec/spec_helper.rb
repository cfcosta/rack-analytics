require "rubygems"
require "rspec"
require "webrat"
require 'rubygems'
require 'rspec'
require 'webrat'
require 'rack/test'

$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__))

require 'rack/analytics'

require 'spec/support/dummy_app'

RSpec.configure do |config|
  config.include Webrat::Matchers
  config.include Rack::Test::Methods
end
