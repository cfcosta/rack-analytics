require 'test_helper'

context "Rack::Analytics::RequestLogger" do
  setup { db.drop_collection 'views' }
  teardown { Rack::Analytics.finish! }

  context "should render a get request correctly" do
    setup { get '/' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equals "homepage"
  end

  context "should render a get request on a inner path correctly" do
    setup { get '/inner-page' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equals "inner page"
  end

  context "should render a post request correctly" do
    setup { post '/' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equals "homepage with post"
  end

  context "should render a put request correctly" do
    setup { put '/' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equals "homepage with put"
  end

  context "should render a delete request correctly" do
    setup { delete '/' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equals "homepage with delete"
  end

  context "should create a access document when visiting the page" do
    setup { get '/' }

    asserts('counter has incremented') { db['views'].count }.equals 1
  end

  context "shouldn't create a access document when with post, put and delete" do
    setup do
      post '/'
      put '/'
      delete '/'
    end

    asserts("counter hasn't incremented") { db['views'].count }.equals 0
  end

  context "should save the path and the time of the access" do
    setup { get '/' }

    asserts('it should have a path key') { db['views'].find_one }.includes 'path'
    asserts('it should have a path set') { db['views'].find_one['path'] }.equals '/'
    asserts('it should have a time key') { db['views'].find_one }.includes 'time'
    asserts('it should have a time set') { db['views'].find_one['time'] }.kind_of Time
  end

  context "should save the referral information" do
    setup { get '/', {}, 'HTTP_REFERER' => 'http://www.google.com' }

    asserts('it should have a referral key') { db['views'].find_one }.includes 'referral'
    asserts('it should have a correct referral set') { db['views'].find_one['referral'] }.equals 'http://www.google.com'
  end

  context "should save the user agent information" do
    setup { get 'views', {}, 'HTTP_USER_AGENT' => 'Firefox' }

    asserts('it should have a user agent key') { db['views'].find_one }.includes 'user_agent'
    asserts('it should have a correct user agent set') { db['views'].find_one['user_agent'] }.equals 'Firefox'
  end
end
