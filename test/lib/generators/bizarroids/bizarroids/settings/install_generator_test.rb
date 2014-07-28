require 'test_helper'
require 'generators/bizarroids/settings/install/install_generator'

module Bizarroids::Settings
  class Bizarroids::Settings::InstallGeneratorTest < Rails::Generators::TestCase
    tests Bizarroids::Settings::InstallGenerator
    destination Rails.root.join('tmp/generators')
    setup do
      prepare_destination
      copy_routes
    end

    test "generator runs without errors" do
      assert_nothing_raised do
        run_generator
      end
    end

    test "generator creates files" do
      run_generator
      assert_file 'config/initializers/bizarroids_settings.rb'
      assert_file "config/locales/bizarroids_settings.en.yml"
      assert_file "config/locales/bizarroids_settings.ru.yml"
      assert_migration 'db/migrate/*create_bizarroids_settings_options.rb'
    end

    def copy_routes
      routes = File.expand_path("config/routes.rb", Rails.root)
      destination = File.join(destination_root, "config")

      FileUtils.mkdir_p(destination)
      FileUtils.cp routes, destination
    end
  end
end
