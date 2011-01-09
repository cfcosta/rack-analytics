require "rubygems"
require "rspec"
require "webrat"

$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__))

RSpec.configure do |config|
  include Webrat::Matchers
end
