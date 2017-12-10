require_relative 'boot'

# Pick the frameworks you want:
require "action_controller/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)
require "remove_data_attributes"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

