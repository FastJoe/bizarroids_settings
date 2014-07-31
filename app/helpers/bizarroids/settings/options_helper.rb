module Bizarroids::Settings::OptionsHelper
  def bizarroids_settings_input_options custom_options={}
    {
      label: @option.human_name,
      input_html: { class: Bizarroids::Settings.options[@option.key.to_sym][:input_class] },
      collection: @option.collection? ? bizarroids_settings_select_collection(@option.key) : nil
    }.merge custom_options
  end

  def bizarroids_settings_select_collection key
    Bizarroids::Settings.options[key.to_sym][:collection]
  end
end
