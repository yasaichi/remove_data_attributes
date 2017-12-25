# frozen_string_literal: true

require "remove_data_attributes/errors"
require "yaml"

module RemoveDataAttributes
  class Configuration
    SUPPORTED_FILE_FORMATS = {
      "YAML" => [".yml", ".yaml"].freeze
    }.freeze

    attr_writer :data_attributes

    class << self
      def from_file(filename)
        loader = loader_for(::File.extname(filename))

        unless loader
          message = "This file format is not supported."
          raise ::RemoveDataAttributes::InvalidConfiguration, message
        end

        ::File.open(filename) { |file| new(loader.load(file)) }
      end

      def supported_file_extensions
        @supported_file_extensions ||= SUPPORTED_FILE_FORMATS.values.flatten.sort
      end

      private

      # :reek:ControlParameter
      def loader_for(extname)
        case extname
        when *SUPPORTED_FILE_FORMATS["YAML"] then ::YAML
        end
      end
    end

    # :reek:ManualDispatch
    def initialize(attributes = {})
      attributes.each do |attribute_name, value|
        method_name = "#{attribute_name}="
        public_send(method_name, value) if respond_to?(method_name)
      end
    end

    def data_attributes
      @data_attributes ||= []
    end
  end
end
