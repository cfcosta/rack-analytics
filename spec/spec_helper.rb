require "rubygems"
require "spec"
require "webrat"

$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__))

Spec::Runner.configure do |config|
  include Webrat::Matchers
end
