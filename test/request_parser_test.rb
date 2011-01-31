require 'teststrap'

context 'Rack::Analytics::RequestParser' do
  helper(:request) { {"HTTP_HOST"=>"example.org", "SERVER_NAME"=>"example.org",
                      "HTTP_USER_AGENT"=>"Firefox", "CONTENT_LENGTH"=>"0", "HTTPS"=>"off",
                      "REMOTE_ADDR"=>"127.0.0.1", "PATH_INFO"=>"/",
                      "SCRIPT_NAME"=>"", "HTTP_COOKIE"=>"", "SERVER_PORT"=>"80",
                      "REQUEST_METHOD"=>"GET", "QUERY_STRING"=>""} }

  context "should parse the default attributes correctly" do
    setup { Rack::Analytics::RequestParser.new.parse(request) }
    
    asserts('it should save the time') { topic.data['time'] }.kind_of Time
    asserts('it should save the path') { topic.data['path'] }.equals '/'
    asserts('it should save the user agent') { topic.data['user_agent'] }.equals 'Firefox'
  end
  
  context "should accept exceptions" do
    setup { Rack::Analytics::RequestParser.new }

    asserts ('it should accept single arguments') do
      topic.except = 'time'
      topic.parse(request).data['time']
    end.nil
    
    asserts ('it should accept multiple values as arguments') do
      topic.except = ['time']
      topic.parse(request).data['time']
    end.nil
  end
end