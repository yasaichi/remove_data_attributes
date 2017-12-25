# frozen_string_literal: true

module RemoveDataAttributes
  class Error < ::StandardError
  end

  class ConfigurationNotFound < ::RemoveDataAttributes::Error
    def initialize(dirname)
      super("No configuration file is found in #{dirname}.")
    end
  end

  class InvalidConfiguration < ::RemoveDataAttributes::Error
  end
end
