# frozen_string_literal: true

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
        processor = ::RemoveDataAttributes::Processor.new(data_attributes)

        ::Module.new do
          method_name = :tag_options
          defined_as_private = private_method_defined?(method_name)

          define_method(method_name) do |options, escape = true|
            options.is_a?(::Hash) ? super(processor.call(options), escape) : super
          end

          private method_name if defined_as_private
        end
      end
    end
  end
end
