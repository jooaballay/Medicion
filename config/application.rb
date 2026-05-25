require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module PortalTransparencia
  class Application < Rails::Application
    config.load_defaults 8.1

    config.autoload_paths << Rails.root.join("app/services")
  end
end
