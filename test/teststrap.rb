require 'rubygems'
require 'webrat'
require 'rack/test'
require 'mongo'
require 'riot'

$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__))

require 'test/support/dummy_app'
require 'test/support/test_helpers'

require 'rack/analytics'

include Webrat::Matchers
include Webrat::Methods
include Rack::Test::Methods

include TestHelpers

Webrat.configure { |c| c.mode = :rack }