module Rack
  module Analytics
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc "Copy rack-analytics default initializers"
        source_root ::File.expand_path('../templates', __FILE__)

        def copy_initializers
          copy_file 'rack-analytics.rb', 'config/initializers/rack-analytics.rb'
        end
      end
    end
  end
end
