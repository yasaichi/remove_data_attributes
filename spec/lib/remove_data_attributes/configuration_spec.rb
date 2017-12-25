# frozen_string_literal: true

require "rails_helper"

RSpec.describe RemoveDataAttributes::Configuration do
  let(:configuration) { described_class.new }

  describe ".from_file" do
    subject { described_class.from_file(filename) }
    let(:filename) { Rails.root.join("config", basename) }

    context "when the file format isn't supported" do
      let(:basename) { "remove_data_attributes.json" }
      it { expect { subject }.to raise_error(RemoveDataAttributes::InvalidConfiguration) }
    end

    context "when the file format is supported, but the file doesn't exist" do
      let(:basename) { "foo.yml" }
      it { expect { subject }.to raise_error(Errno::ENOENT) }
    end

    context "when the file format is supported, and the file exists" do
      let(:basename) { "remove_data_attributes.yml" }
      let(:expectation) { { data_attributes: ["data-test"] } }

      it { is_expected.to be_an_instance_of(described_class) & have_attributes(expectation) }
    end
  end

  describe ".supported_file_extensions" do
    subject { described_class.supported_file_extensions }

    it "should be a sorted Array of file extension" do
      expect(subject).to eq subject.sort
      expect(subject).to all be_a(String) & start_with(".")
    end
  end

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
