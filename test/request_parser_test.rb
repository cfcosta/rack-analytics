require 'teststrap'

context 'Rack::Analytics::RequestParser' do
  helper(:request) { {"HTTP_HOST"=>"example.org", "SERVER_NAME"=>"example.org",
                      "HTTP_USER_AGENT"=>"Firefox", "CONTENT_LENGTH"=>"0", "HTTPS"=>"off", 
                      "REMOTE_ADDR"=>"127.0.0.1", "PATH_INFO"=>"/",
                      "SCRIPT_NAME"=>"", "HTTP_COOKIE"=>"", "SERVER_PORT"=>"80",
                      "REQUEST_METHOD"=>"GET", "QUERY_STRING"=>""} }

  context "should parse the default attributes correctly" do
    setup { Rack::Analytics::RequestParser.new.parse(request) }
    
    asserts('it should generate the time') { topic.data['time'] }.kind_of Time
    asserts('it should generate the path') { topic.data['path'] }.equals '/'
  end
end