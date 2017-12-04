# frozen_string_literal: true

require "rails_helper"

RSpec.describe RemoveDataAttributes::Configuration do
  let(:configuration) { described_class.new }

  describe "#data_attributes" do
    subject { configuration.data_attributes }

    context "when the value was set in advance" do
      let(:value) { %i(data-foo) }

      before do
        configuration.data_attributes = value
      end

      it { is_expected.to eq value }
    end

    context "when the value was not set in advance" do
      it { is_expected.to eq [] }
    end
  end
end
