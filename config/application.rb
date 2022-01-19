require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Umfragequiz
    class Application < Rails::Application
        # Initialize configuration defaults for originally generated Rails version.
        config.load_defaults 6.1

        # Configuration for the application, engines, and railties goes here.
        #
        # These settings can be overridden in specific environments using the files
        # in config/environments, which are processed later.
        #
        # config.time_zone = "Central Time (US & Canada)"
        # config.eager_load_paths << Rails.root.join("extras")

        # Models are organized in sub-directories
        config.eager_load_paths += Dir[Rails.root.join('app', 'models', '{**/}')]

        # Only loads a smaller set of middleware suitable for API only apps.
        # Middleware like session, flash, cookies can be added back manually.
        # Skip views, helpers and assets when generating a new resource.
        config.api_only = true

        config.after_initialize do
            Rails.application.eager_load!
        end
        
        config.middleware.insert_after ActionDispatch::ParamsParser, Warden::Manager do |manager|
            manager.default_strategies :json_web_token
            manager.failure_app = UnauthorizedController
        end
    end
end
