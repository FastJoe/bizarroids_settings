require 'test_helper'
require 'generators/bizarroids/settings/install/install_generator'

module Bizarroids::Settings
  class Bizarroids::Settings::InstallGeneratorTest < Rails::Generators::TestCase
    tests Bizarroids::Settings::InstallGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    test "generator runs without errors" do
      assert_nothing_raised do
        run_generator
      end
    end
  end
end
