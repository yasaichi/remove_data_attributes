# frozen_string_literal: true

require "rails/generators/base"

module RemoveDataAttributes
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root ::File.expand_path("../templates", __FILE__)

      def copy_initializer
        copy_file "remove_data_attributes.rb", "config/initializers/remove_data_attributes.rb"
      end
    end
  end
end
