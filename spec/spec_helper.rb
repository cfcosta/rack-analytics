require "rubygems"
require "rspec"
require "webrat"

$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__))

require 'rack/analytics'

require 'spec/support/dummy_app'

RSpec.configure do |config|
  include Webrat::Matchers
end
