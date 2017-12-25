# frozen_string_literal: true

require "rails/generators/base"

module RemoveDataAttributes
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root ::File.expand_path("../templates", __FILE__)

      def copy_configuration_file
        copy_file "remove_data_attributes.yml", "config/remove_data_attributes.yml"
      end
    end
  end
end
