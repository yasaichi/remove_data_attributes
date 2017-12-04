# frozen_string_literal: true

require "rails_helper"

RSpec.describe RemoveDataAttributes::Processor do
  let(:processor) { described_class.new(data_attributes) }

  describe "#call" do
    let(:described_method) { -> { processor.call(hash) } }
    let(:data_attributes) { %w(data-foo-bar) }

    context %q{when `hash` include neither :data nor string matching /\Adata(-[^-]+)*\z/} do
      let(:hash) { { "data-foo-Bar" => "value", "data-foo_bar": "value" } }

      describe "return value" do
        subject { described_method.call }

        it { is_expected.to eq hash }
        it { is_expected.not_to be hash }
      end

      describe "argument" do
        subject { hash }

        before do
          described_method.call
        end

        it { is_expected.to eq("data-foo-Bar" => "value", "data-foo_bar": "value") }
      end
    end

    context %q{when `hash` include string matching /\Adata(-[^-]+)+\z/} do
      let(:hash) { { "data-foo-bar": "value", "data-foo_bar" => "value" } }

      describe "return value" do
        subject { described_method.call }
        it { is_expected.to eq("data-foo_bar" => "value") }
      end

      describe "argument" do
        subject { hash }

        before do
          described_method.call
        end

        it { is_expected.to eq("data-foo-bar": "value", "data-foo_bar" => "value") }
      end
    end

    context "when `hash[:data]` is nil" do
      let(:hash) { { data: nil } }

      describe "return value" do
        subject { described_method.call }

        it { is_expected.to eq hash }
        it { is_expected.not_to be hash }
      end

      describe "argument" do
        subject { hash }

        before do
          described_method.call
        end

        it { is_expected.to eq(data: nil) }
      end
    end

    context "when `hash[:data]` includes no keys passed into the initializer" do
      let(:hash) { { data: { "foo-Bar" => "value", "foo_Bar": "value" } } }

      describe "return value" do
        subject { described_method.call }

        it { is_expected.to eq hash }
        it { is_expected.not_to be hash }
      end

      describe "argument" do
        subject { hash }

        before do
          described_method.call
        end

        it { is_expected.to eq(data: { "foo-Bar" => "value", "foo_Bar": "value" }) }
      end
    end

    context "when `hash[:data]` includes keys passed into the initializer" do
      let(:hash) { { data: { "foo-bar" => "value", "foo_Bar": "value" } } }

      describe "return value" do
        subject { described_method.call }
        it { is_expected.to eq(data: { "foo_Bar": "value" }) }
      end

      describe "argument" do
        subject { hash }

        before do
          described_method.call
        end

        it { is_expected.to eq(data: { "foo-bar" => "value", "foo_Bar": "value" }) }
      end
    end

    context "when `hash[:data]` includes keys where underscores are used as delimiter" do
      let(:hash) { { data: { "foo-Bar" => "value", "foo_bar": "value" } } }

      describe "return value" do
        subject { described_method.call }
        it { is_expected.to eq(data: { "foo-Bar" => "value" }) }
      end

      describe "argument" do
        subject { hash }

        before do
          described_method.call
        end

        it { is_expected.to eq(data: { "foo-Bar" => "value", "foo_bar": "value" }) }
      end
    end

    context 'when `hash["data"]` includes no keys passed into the initializer' do
      let(:hash) { { "data" => { "foo-Bar" => "value", "foo_Bar": "value" } } }

      describe "return value" do
        subject { described_method.call }

        it { is_expected.to eq hash }
        it { is_expected.not_to be hash }
      end

      describe "argument" do
        subject { hash }

        before do
          described_method.call
        end

        it { is_expected.to eq("data" => { "foo-Bar" => "value", "foo_Bar": "value" }) }
      end
    end

    context 'when `hash["data"]` includes keys passed into the initializer' do
      let(:hash) { { "data" => { "foo-bar": "value", "foo_Bar" => "value" } } }

      describe "return value" do
        subject { described_method.call }
        it { is_expected.to eq("data" => { "foo_Bar" => "value" }) }
      end

      describe "argument" do
        subject { hash }

        before do
          described_method.call
        end

        it { is_expected.to eq("data" => { "foo-bar": "value", "foo_Bar" => "value" }) }
      end
    end

    context 'when `hash["data"]` includes keys where underscores are used as delimiter' do
      let(:hash) { { "data" => { "foo-Bar": "value", "foo_bar" => "value" } } }

      describe "return value" do
        subject { described_method.call }
        it { is_expected.to eq("data" => { "foo-Bar": "value" }) }
      end

      describe "argument" do
        subject { hash }

        before do
          described_method.call
        end

        it { is_expected.to eq("data" => { "foo-Bar": "value", "foo_bar" => "value" }) }
      end
    end
  end
end
