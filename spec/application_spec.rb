require 'spec_helper'

describe Rack::Analytics::Application do
  it "should render a get request correctly" do
    get '/'

    last_response.should be_ok
    last_response.body.should == "homepage"
  end

  it "should render a get request on a inner path correctly" do
    get '/inner-page'

    last_response.should be_ok
    last_response.body.should == "inner page"
  end

  it "should render a post request correctly" do
    post '/'

    last_response.should be_ok
    last_response.body.should == "homepage with post"
  end

  it "should render a put request correctly" do
    put '/'

    last_response.should be_ok
    last_response.body.should == "homepage with put"
  end

  it "should render a delete request correctly" do
    delete '/'

    last_response.should be_ok
    last_response.body.should == "homepage with delete"
  end

  it "should increment access counter of the root page" do
    db.set('analytics:/:views', 0)

    get '/'

    db.get('analytics:/:views').should == "1"
  end

  it "should not increment access counter on requests other than get" do
    db.set('analytics:/:views', 0)

    post '/'
    put '/'
    delete '/'

    db.get('analytics:/:views').should == "0"
  end

  it "should save the referers informations" do
    db.del 'analytics:/:referers'

    get '/', {}, 'HTTP_REFERER' => 'http://www.google.com'

    MessagePack.unpack(db.get('analytics:/:referers')).should == {'http://www.google.com' => 1}
  end
end
