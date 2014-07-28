module Bizarroids::Settings
  module OptionsHelper
    def input_options custom_options={}
      {
        label: @option.human_name,
        collection: @option.collection? ? input_collection(@option.key) : nil
      }.merge custom_options
    end

    def input_collection key
      Bizarroids::Settings.options[key.to_sym][:collection]
    end
  end
end
