# frozen_string_literal: true

require "rails_helper"

RSpec.describe RemoveDataAttributes do
  describe ".configuration" do
    subject { described_class.configuration }
    it { is_expected.to be_an_instance_of RemoveDataAttributes::Configuration }
  end

  describe ".configure" do
    subject { -> (block) { described_class.configure(&block) } }
    it { is_expected.to yield_with_args(described_class.configuration) }
  end
end
