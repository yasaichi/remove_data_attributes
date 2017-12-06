# frozen_string_literal: true

require "active_support"
require "active_support/lazy_load_hooks"
require "rails/railtie"
require "remove_data_attributes/configuration"
require "remove_data_attributes/tag_options_filter"

module RemoveDataAttributes
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      ::ActiveSupport.on_load(:action_view) do
        patch = ::RemoveDataAttributes::TagOptionsFilter[
          ::RemoveDataAttributes.configuration.data_attributes
        ]

        if Gem::Version.new(Rails.version) < Gem::Version.new("5.1")
          ::ActionView::Helpers::TagHelper.prepend(patch)
        else
          ::ActionView::Helpers::TagHelper::TagBuilder.prepend(patch)
        end
      end
    end
  end
end
