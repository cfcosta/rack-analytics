require 'teststrap'

context Rack::Analytics do
  context "it should change configuration when setup'ing" do
    helper(:object) { Object.new }      
    
    context "db_name" do
      setup do
        Rack::Analytics.setup do |config|
          config.db_name = "foo"
        end

        Rack::Analytics
      end

      asserts('should set db name correctly') { topic.db_name }.equals "foo"
    end
  end
end