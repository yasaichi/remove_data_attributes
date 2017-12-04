# frozen_string_literal: true

require "set"
require "active_support"
require "active_support/core_ext/string/inflections"

module RemoveDataAttributes
  class Processor
    DATA_ATTRIBUTE_KEYS = ["data", :data].freeze
    DATA_ATTRIBUTE_PATTERN = /\Adata-(?<attribute_name>.+)\z/

    def initialize(data_attributes)
      valid_attribute_names = Array(data_attributes)
        .map(&DATA_ATTRIBUTE_PATTERN.method(:match))
        .select(&:itself)
        .map { |md| md[:attribute_name] }

      @target_keys = valid_attribute_names.map { |name| "data-#{name}" }.to_set
      @target_keys_in_nested_hash = valid_attribute_names.map(&method(:normalize)).to_set
    end

    def call(hash)
      new_hash = hash.reject { |key, _| @target_keys.include?(key.to_s) }

      DATA_ATTRIBUTE_KEYS.each do |key|
        nested_hash = hash[key]
        next unless nested_hash.is_a?(::Hash)

        new_hash[key] = nested_hash
          .reject { |key, _| @target_keys_in_nested_hash.include?(normalize(key)) }
      end

      new_hash
    end

    private

    # :reek:UtilityFunction
    def normalize(attribute_name)
      attribute_name.to_s.dasherize
    end
  end
end
