module TestHelpers
  def app
    Rack::Builder.new do
      use Rack::Analytics::RequestLogger, :db => mongo, :queue => queue
      run DummyApp
    end
  end

  def mongo
    connection = Mongo::Connection.new
    connection.db 'rack-analytics-test'
  end

  def queue
    Queue.new
  end
end