module TestHelpers
  def app
    Rack::Builder.new do
      Rack::Analytics.db = mongo

      use Rack::Analytics::RequestLogger
      run DummyApp
    end
  end

  def mongo
    connection = Mongo::Connection.new
    connection.db 'rack-analytics-test'
  end
end