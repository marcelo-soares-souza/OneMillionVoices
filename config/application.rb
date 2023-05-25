# frozen_string_literal: true

require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Agroecologia
  class Application < Rails::Application
    config.load_defaults 7.0
    config.exceptions_app = self.routes
    config.active_record.legacy_connection_handling = false

    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.log_tags  = [:subdomain, :uuid]
    config.logger    = ActiveSupport::TaggedLogging.new(logger)

    config.generators do |g|
      g.template_engine nil
      g.test_framework  nil
      g.assets false
      g.helper false
      g.stylesheets false
    end
  end
end
