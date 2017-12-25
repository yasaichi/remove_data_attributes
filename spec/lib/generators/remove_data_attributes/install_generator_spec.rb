# frozen_string_literal: true

require "yaml"
require "rails_helper"
require "generators/remove_data_attributes/install/install_generator"

RSpec.describe RemoveDataAttributes::Generators::InstallGenerator, type: :generator do
  destination File.expand_path("../../../../../tmp", __FILE__)

  before do
    prepare_destination
  end

  describe "the generated files" do
    before do
      run_generator
    end

    describe "the configuration" do
      subject { YAML.load(File.read(filename)) }
      let(:filename) { file("config/remove_data_attributes.yml") }

      it { is_expected.to eq("data_attributes" => nil) }
    end
  end
end
