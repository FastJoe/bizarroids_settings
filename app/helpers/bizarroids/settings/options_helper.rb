module Bizarroids::Settings::OptionsHelper
  def bizarroids_settings_input_options custom_options={}
    key = @option.sym_key
    {
      label: @option.human_name,
      required: @option.required,
      input_html: { class: Bizarroids::Settings.options[key][:input_class] },
      collection: @option.collection? ? bizarroids_settings_select_collection(key) : nil
    }.merge custom_options
  end

  def bizarroids_settings_select_collection key
    Bizarroids::Settings.options[key][:collection]
  end
end
