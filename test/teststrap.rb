require 'bundler/setup'
Bundler.require

require 'rack/test'
require 'riot'

require 'test/support/dummy_app'
require 'test/support/test_helpers'

require 'rack/analytics'

include Rack::Test::Methods

include TestHelpers
