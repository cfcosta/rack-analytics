require 'rubygems'
require 'rack/test'
require 'mongo'
require 'riot'

require 'test/support/dummy_app'
require 'test/support/test_helpers'

require 'rack/analytics'

include Rack::Test::Methods

include TestHelpers