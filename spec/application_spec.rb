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
end
