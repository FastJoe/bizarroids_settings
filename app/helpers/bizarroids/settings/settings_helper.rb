module Bizarroids::Settings
  module SettingsHelper
    def bizarroids_edit_button path
      link_to path, class: 'btn btn-link btn-xs text-primary' do
        content_tag :span, '', class: 'glyphicon glyphicon-pencil'
      end
    end

    def bizarroids_t key
      t key, scope: :bizarroids
    end

    def bizarroids_settings_menu_link
      link_to bizarroids_t('settings.name'),
        bizarroids_settings_engine.options_path,
        class: [bizarroids_settings_menu_link_class, 'list-group-item']
    end

    def bizarroids_settings_menu_link_class
      bizarroids_settings_menu_link_active? ? :active : nil
    end

    def bizarroids_settings_menu_link_active?
      controller.kind_of?(Bizarroids::Settings::OptionsController)
    end
  end
end
