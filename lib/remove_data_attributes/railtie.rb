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
        data_attributes = ::RemoveDataAttributes.configuration.data_attributes

        ::ActionView::Helpers::TagHelper::TagBuilder.prepend(
          ::RemoveDataAttributes::TagOptionsFilter[data_attributes]
        )
      end
    end
  end
end
