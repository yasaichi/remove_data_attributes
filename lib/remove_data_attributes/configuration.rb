# frozen_string_literal: true

module RemoveDataAttributes
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= ::RemoveDataAttributes::Configuration.new
    end

    def configure
      yield(configuration) if block_given?
    end
  end

  class Configuration
    attr_writer :data_attributes

    def data_attributes
      @data_attributes ||= []
    end
  end
end
