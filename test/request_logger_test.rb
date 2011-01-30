require 'teststrap'

context "Rack::Analytics::RequestLogger" do
  helper(:db) { mongo }
  
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
    setup do
      db.drop_collection '/'
      get '/'
    end

    asserts('counter has incremented') { db['/'].count }.equals 1
  end

  context "shouldn't create a access document when with post, put and delete" do
    setup do
      db.drop_collection '/'
      post '/'
      put '/'
      delete '/'
    end

    asserts('counter has incremented') { db['/'].count }.equals 0
  end

  context "should save the time of the access" do
    setup do
      db.drop_collection '/'
      
      get '/'
    end

    asserts('it should have a time key') { db['/'].find_one }.includes 'time'
    asserts('it should have a time set') { db['/'].find_one['time'] }.kind_of Time
  end

  context "should save the referral information" do
    setup do
      db.drop_collection '/'
      
      get '/', {}, 'HTTP_REFERER' => 'http://www.google.com'
    end

    asserts('it should have a referral key') { db['/'].find_one }.includes 'referral'
    asserts('it should have a correct referral set') { db['/'].find_one['referral'] }.equals 'http://www.google.com'
  end
end
