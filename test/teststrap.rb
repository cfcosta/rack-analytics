require 'rubygems'
require 'rack/test'
require 'mongo'
require 'riot'

$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__))

require 'test/support/dummy_app'
require 'test/support/test_helpers'

require 'rack/analytics'

include Rack::Test::Methods

include TestHelpers