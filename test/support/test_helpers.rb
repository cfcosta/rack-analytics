module TestHelpers
  def app
    Rack::Builder.new do
      Rack::Analytics.db = db

      use Rack::Analytics::RequestLogger
      run DummyApp
    end
  end

  def db
    connection = Mongo::Connection.new
    connection.db 'rack-analytics-test'
  end
end
