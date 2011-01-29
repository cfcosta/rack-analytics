require 'teststrap'

describe Rack::Analytics::RequestLogger do
  context "should render a get request correctly" do
    setup { get '/' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equal? "homepage"
  end

  context "should render a get request on a inner path correctly" do
    setup { get '/inner-page' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equal? "inner page"
  end

  context "should render a post request correctly" do
    setup { post '/' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equal? "homepage"
  end

  context "should render a put request correctly" do
    setup { put '/' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equal? "homepage"
  end

  context "should render a delete request correctly" do
    setup { delete '/' }

    asserts('response is ok') { last_response.ok? }
    asserts('response has correct body') { last_response.body }.equal? "homepage"
  end

  context "should increment access count of the page" do
    setup do
      db.set("#{namespace}:/:views", 0)
      get '/'
    end

    asserts('counter has incremented') { db.get("#{namespace}:/:views") }.equals "1"
  end

  context "should not increment access on put, post and delete requests" do
    setup do
      db.set("#{namespace}:/:views", 0)
      post '/'
      put '/'
      delete '/'
    end

    asserts("counter hasn't incremented") { db.get("#{namespace}:/:views") }.equals "0"
  end

  context "should save the referers informations" do
    setup do
      db.del "#{namespace}:/:referers"
      get '/', {}, 'HTTP_REFERER' => 'http://www.google.com'
    end

    asserts('check referral information') { MessagePack.unpack(db.get("#{namespace}:/:referers")) }.equals({'http://www.google.com' => 1})
  end

  context "should increment the referers informations" do
    setup do
      db.del "#{namespace}:/:referers"
      get '/', {}, 'HTTP_REFERER' => 'http://www.google.com'
      get '/', {}, 'HTTP_REFERER' => 'http://www.google.com'
    end

    asserts('check referral information') { MessagePack.unpack(db.get("#{namespace}:/:referers")) }.equals({'http://www.google.com' => 2})
  end
end
