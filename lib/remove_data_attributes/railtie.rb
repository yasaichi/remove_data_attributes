# frozen_string_literal: true

require "active_support"
require "active_support/lazy_load_hooks"
require "rails/railtie"
require "remove_data_attributes/configuration"
require "remove_data_attributes/tag_options_filter"

module RemoveDataAttributes
  class Railtie < ::Rails::Railtie
    initializer "remove_data_attributes" do
      configuration = ::RemoveDataAttributes::Configuration.from_file(find_configuration_file)
      next if configuration.data_attributes.empty?

      ::ActiveSupport.on_load(:action_view) do
        patch = ::RemoveDataAttributes::TagOptionsFilter[configuration.data_attributes]

        if ::Gem::Version.new(::Rails.version) < ::Gem::Version.new("5.1")
          ::ActionView::Helpers::TagHelper.include(patch)
        else
          ::ActionView::Helpers::TagHelper::TagBuilder.include(patch)
        end
      end
    end

    private

    def find_configuration_file
      root = ::Rails.root.join("config")
      extensions = ::RemoveDataAttributes::Configuration.supported_file_extensions

      ::Dir.glob(root.join("remove_data_attributes{#{extensions.join(',')}}")).first ||
        raise(::RemoveDataAttributes::ConfigurationNotFound, root)
    end
  end
end
