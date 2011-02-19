# Config file for Rack::Analytics

Rack::Analytics.setup do |config|
  # To change the database name only
  # config.db_name = 'mydb'

  # To change the database connection completely
  # config.db = Mongo::Connection.new.db 'mydb'

  # Parser configuration
  # When this is active, only those fields will be logged
  # config.parser.only = ['time', 'path', 'user_agent', 'referral']

  # The fields that shouldn't be parsed
  # config.parser.except = nil
end
