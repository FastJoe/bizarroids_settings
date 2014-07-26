require 'test_helper'

module Bizarroids
  class SettingsTest < ActiveSupport::TestCase
    test "is a module module" do
      assert_kind_of Module, Bizarroids::Settings
    end

    #
    # config
    #
    test 'setup block yields self' do
      Settings.setup do |config|
        assert_equal Settings, config
      end
    end

    test "creating option from config" do
      create_string_option
      assert_equal Settings[:string_option], 'MyStringValue'
    end

    test "collection must be an array" do
      clean_options

      assert_raises Bizarroids::Settings::ConfigError do
        Settings.setup do |config|
          config.option :string_option, :string, collection: true
        end
      end
    end

    test "collection sets attribute to true" do
      clean_options

      Settings.setup do |config|
        config.option :string_option, :string, collection: %w(a b c)
      end

      assert Bizarroids::Settings::Option.find_by(key: :string_option).collection
    end

    test "Duplicate option raises error" do
      clean_options

      assert_raises Bizarroids::Settings::ConfigError do
        Settings.setup do |config|
          config.option :string_option, :string
          config.option :string_option, :string
        end
      end
    end

    test "Require flag requires non blank value" do
      assert_raises Bizarroids::Settings::ConfigError do
        clean_options
        Settings.setup do |config|
          config.option :string_option, :string, required: true
        end
      end
    end

    test "Hidden flag requires non blank value" do
      assert_raises Bizarroids::Settings::ConfigError do
        clean_options
        Settings.setup do |config|
          config.option :string_option, :string, hidden: true
        end
      end
    end

    #
    # get & set
    #
    test "respond to #get" do
      assert_respond_to Bizarroids::Settings, :get
    end

    test "get :key retuns value" do
      create_string_option
      assert_equal Bizarroids::Settings.get(:string_option), 'MyStringValue'
    end

    test "respond to #set" do
      assert_respond_to Bizarroids::Settings, :set
    end

    test "set :key, value updates option" do
      create_string_option
      str = "NewStringValue"
      assert_equal Bizarroids::Settings.set(:string_option, str), true
      assert_equal Bizarroids::Settings.get(:string_option), str
    end

    #
    # aliases
    #
    test "respond to #[]" do
      assert_respond_to Bizarroids::Settings, :[]
    end

    test "respond to #[]=" do
      assert_respond_to Bizarroids::Settings, :[]=
    end

    #
    # unknown key
    #
    test "get raises ActiveRecord::RecordNotFound with unknown key" do
      create_string_option
      assert_raises ActiveRecord::RecordNotFound do
        Bizarroids::Settings.get :not_existing_key
      end
    end


    test "set raises ActiveRecord::RecordNotFound with unknown key" do
      create_string_option
      assert_raises ActiveRecord::RecordNotFound do
        Bizarroids::Settings.set :not_existing_key, 'MyString'
      end
    end

    #
    # not configured key
    #
    test "get raises ActiveRecord::RecordNotFound with not configured key" do
      Settings::Option.create key: :not_configured_key,
        value_type: :string, value: 'MyString'

      assert_raises ActiveRecord::RecordNotFound do
        Bizarroids::Settings.get :not_configured_key
      end
    end

    test "set raises ActiveRecord::RecordNotFound with not configured key" do
      Settings::Option.create key: :not_configured_key,
        value_type: :string, value: 'MyString'

      assert_raises ActiveRecord::RecordNotFound do
        Bizarroids::Settings.set :not_configured_key, 'MyString'
      end
    end

    test "keys returns all known keys" do
      create_string_option
      assert_equal Bizarroids::Settings.keys, [:string_option]
    end

  end
end
