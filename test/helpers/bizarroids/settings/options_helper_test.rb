require 'test_helper'

module Bizarroids::Settings
  class OptionsHelperTest < ActionView::TestCase
    test 'bizarroids_settings_input_options should return hash' do
      create_string_option
      @option = Bizarroids::Settings::Option.find_by key: :string_option
      assert_instance_of Hash, bizarroids_settings_input_options
      assert bizarroids_settings_input_options(a: 1)[:a], 1
    end

    test 'bizarroids_settings_select_collection should return array' do
      create_string_collection_option
      assert_instance_of Array, bizarroids_settings_select_collection(:string_collection_option)
    end
  end
end
