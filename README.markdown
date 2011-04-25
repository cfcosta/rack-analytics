# Rack-Analytics #

**Rack-Analytics** is a rack middleware that creates a log of all user requests to your application and saves them on a MongoDB database.

All requests are created on a separated thread, so it won't add a lot of overhead on each requests.

## Installation on Rails 3 ##

Add this line on your `Gemfile`:

``` ruby
gem 'rack-analytics'
```

Run `rails generate rack:analytics:install` to install the initializer file on `config/initializers/rack-analytics.rb`. Some configuration options are highlighted on this file.

Then, on your `config/application.rb`, add the following line after inside your Application class:

``` ruby
config.middlewares.insert_after Rack::Lock, Rack::Analytics::RequestLogger
```

## Installation on another Rack applications ##

If you're using Bundler, you can add this line on your `Gemfile`:

``` ruby
gem 'rack-analytics'
```

Then, run `bundle` to install the gem. If you don't use Bundler, you will need to install the gem manually with the following command:

``` ruby
gem install rack-analytics
```

Either way, with the gem installed, you can add this on your `config.ru`:

``` ruby
require 'rack/analytics'
use Rack::Analytics::RequestLogger
```

It will do the trick, connecting to MongoDB and start to log all your requests. If you need to change some of the configuration of the database, you can do:

``` ruby
require 'rack/analytics'

# To change the database name only
Rack::Analytics.db_name = 'mydb'

# To change the database connection completely
Rack::Analytics.db = Mongo::Connection.new.db 'mydb'

use Rack::Analytics::RequestLogger
```

**Rack-Analytics** runs on a threaded environment, and just like `db` and `db_name`, you can set the Queue and the Thread for the parallelism with the keys `queue` and `thread`, respectively **(i don't advise doing that, though)**.

You can also change the parser, to remove some of the fields (on the future, you'll be able to create your own fields based on the request headers):

``` ruby
require 'rack/analytics'

parser = Rack::Analytics::RequestParser.new

# Will log only the path and time
parser.only = ['time', 'path']

# Won't log the time
parser.except = 'time'

Rack::Analytics.parser = parser

use Rack::Analytics::RequestLogger
```

Be sure to just use one of those, since they are mutually excludent (and `only` has a preference over `except`). You can also create custom parsers, too, you just need to feed the parser with lambdas, like that:

``` ruby
require 'rack/analytics'

parser = Rack::Analytics::RequestParser.new

parser << lambda { |env, data| data['port'] = env['SERVER_PORT'] }
parser << lambda { |env, data| data['test'] = env['rack.test'] }

Rack::Analytics.parser = parser

use Rack::Analytics::RequestLogger
```

The env is a hash with all the parameters of the request, and the data is the fields that are saved on the MongoDB. Just be creative. You can use any kind of object, though, as long that they respond to `call` with two arguments.

## Notes on Patches/Pull Requests ##

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## License ##

Copyright (c) 2011, Cainã Costa <cainan.costa@gmail.com>

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

## Thanks ##

Those are the people that helped me with this project, both with code and/or with guidance. Put your name here if you create a pull request and think you deserves it!

* Rafael França <rafael.ufs@gmail.com>
