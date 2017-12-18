# frozen_string_literal: true

RemoveDataAttributes.configure do |config|
  # Configure which data attributes should be removed. Note that no attributes
  # are removed by default.
  config.data_attributes = ["data-test"]
end
