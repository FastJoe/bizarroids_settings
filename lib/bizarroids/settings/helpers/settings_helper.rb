module Bizarroids::Settings
  module SettingsHelper
    def bizarroids_edit_button obj
      link_to([:edit, obj], class: 'btn btn-link btn-xs text-primary') do
        content_tag :span, '', class: 'glyphicon glyphicon-pencil'
      end
    end

    def bizarroids_t key
      t key, scope: :bizarroids
    end

    def bizarroids_settings_menu_link
      link_to Bizarroids::Settings::Option.model_name.human(count: 10),
        bizarroids_settings.options_path,
        class: bizarroids_settings_menu_link_class
    end

    def bizarroids_settings_menu_link_class
      bizarroids_settings_menu_link_active? ? :active : nil
    end

    def bizarroids_settings_menu_link_active?
      controller.kind_of?(Bizarroids::Settings::OptionsController)
    end
  end
end
