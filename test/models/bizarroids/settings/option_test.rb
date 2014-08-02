require 'test_helper'

module Bizarroids::Settings
  class OptionTest < ActiveSupport::TestCase
    test "the truth" do
        assert true
    end

    test "test fixtures" do
      create_string_option # TODO remove with fixtures
      assert_equal Option.count, 1
    end

    test "create string type" do
      # TODO fixtures
      option = Option.create key: :test_string, value_type: :string, value: 'MyString'

      assert_equal option.persisted?, true
      assert_equal option.value, 'MyString'
    end

    test "should validate presence of value if required set to true" do
      # TODO fixtures
      option = Option.create key: :test_string, value_type: :string, required: true

      assert option.invalid?
      assert option.errors.messages.include?(:string_value)
    end

    test "set_value should update option" do
      # TODO fixtures
      option = Option.create key: :test_string, value_type: :string, value: 'MyString'

      option.set_value 'MyNewString'
      assert_equal option.value, 'MyNewString'
    end

    test 'avaliable_values' do
      clean_options
      Bizarroids::Settings.setup do |config|
        config.option :string_option, :string, collection: %w(a b c)
      end

      assert_equal Option.find_by(key: :string_option).avaliable_values, %w(a b c)

    end
  end
end
