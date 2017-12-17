# frozen_string_literal: true

require "active_support"
require "active_support/concern"
require "remove_data_attributes/processor"

module RemoveDataAttributes
  module TagOptionsFilter
    class << self
      def [](data_attributes)
        module_cache[data_attributes] ||= module_for(data_attributes)
      end

      private

      def module_cache
        @module_cache ||= {}
      end

      def module_for(data_attributes)
        method_name = :tag_options
        processor = ::RemoveDataAttributes::Processor.new(data_attributes)

        ::Module.new do
          extend ::ActiveSupport::Concern

          included do |klass|
            patch = ::Module.new do
              define_method(method_name) do |options, escape = true|
                options.is_a?(::Hash) ?
                  super(processor.call(options), escape) : super(options, escape)
              end

              private method_name if klass.private_method_defined?(method_name)
            end

            klass.prepend(patch)
          end
        end
      end
    end
  end
end
