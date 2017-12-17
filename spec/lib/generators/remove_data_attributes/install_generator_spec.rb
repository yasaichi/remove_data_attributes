# frozen_string_literal: true

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

    describe "initializer" do
      subject { file("config/initializers/remove_data_attributes.rb") }

      let(:expected_content) do
        /\A
          RemoveDataAttributes\.configure\ do\ \|config\|\n
          .*
          \#\ config.data_attributes\ =\ \[.+\]\n
          .*
          end
        \Z/mx
      end

      it { is_expected.to exist & have_correct_syntax & contain(expected_content) }
    end
  end
end
