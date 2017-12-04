# frozen_string_literal: true

require "rails_helper"

RSpec.describe ActionView::Helpers, type: :helper do
  describe "#tag" do
    subject { helper.tag.p(data_attribute.to_sym => "value") }

    # NOTE: The config file exists in spec/dummy/config/initializers.
    context "when `options` includes no keys specified in the configuration" do
      let(:data_attribute) { "data-foo" }
      it { is_expected.to include data_attribute }
    end

    context "when `options` includes keys specified in the configuration" do
      let(:data_attribute) { "data-test" }
      it { is_expected.not_to include data_attribute }
    end
  end
end
