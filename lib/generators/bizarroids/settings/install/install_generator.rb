require 'rails/generators/active_record/migration'

class Bizarroids::Settings::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  include ActiveRecord::Generators::Migration

  def copy_migration
    migration_template 'options_migration.rb', 'db/migrate/create_bizarroids_settings_options.rb'
  end

  def create_initalizer
    initializer 'bizarroids_settings.rb', File.read(File.join(self.class.source_root, 'initializer.rb'))
  end

  def add_route
    route "mount Bizarroids::Settings::Engine => '/admin'"
  end

  def copy_translation_files
    copy_file "bizarroids_settings.en.yml", "config/locales/bizarroids_settings.en.yml"
    copy_file "bizarroids_settings.ru.yml", "config/locales/bizarroids_settings.ru.yml"
  end
end
