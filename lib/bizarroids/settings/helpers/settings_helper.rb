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
      content_tag :li, class: (controller.kind_of?(Bizarroids::Settings::OptionsController) ? :active : nil) do
        link_to Bizarroids::Settings::Option.model_name.human(count: 10), bizarroids_settings.options_path
      end
    end
  end
end
