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
          define_method(:tag_options) do |options, escape = true|
            options.is_a?(::Hash) ? super(processor.call(options), escape) : super
          end
        end
      end
    end
  end
end
