# frozen_string_literal: true

require "rails_helper"

RSpec.describe RemoveDataAttributes::TagOptionsFilter do
  describe ".[]" do
    let(:data_attributes) { ["data-foo"] }
    let(:return_value) { described_class[data_attributes] }
    let(:tag_builder_dummy) do
      Class.new do
        # :reek:BooleanParameter :reek:UnusedParameters
        def tag_options(options, escape = true); end
      end
    end

    describe "return value" do
      subject { return_value }
      it { is_expected.to eq described_class[data_attributes] }
    end

    describe "method visibility of #tag_options" do
      subject { tag_builder_dummy }

      context "when superclass#tag_options is defined as public method" do
        before do
          subject.include(return_value)
        end

        it { expect(subject.public_method_defined?(:tag_options)).to eq true }
      end

      context "when superclass#tag_options is defined as private method" do
        before do
          subject.class_exec { private :tag_options }
          subject.include(return_value)
        end

        it { expect(subject.private_method_defined?(:tag_options)).to eq true }
      end
    end

    describe "arguments passed to superclass#tag_options" do
      subject { tag_builder_dummy.new }

      before do
        allow_any_instance_of(subject.class).to receive(:tag_options)
        subject.class.include(return_value)

        subject.tag_options(*args)
      end

      context "when `options` isn't a Hash" do
        let(:args) { [nil, true] }
        it { is_expected.to have_received(:tag_options).with(*args) }
      end

      context "when `options` is a Hash" do
        let(:args) { [{ "data-foo": "value" }, false] }
        it { is_expected.to have_received(:tag_options).with({}, false) }
      end
    end
  end
end
