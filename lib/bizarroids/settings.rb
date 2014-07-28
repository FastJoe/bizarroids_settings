require 'inherited_resources'
require 'simple_form'
require 'bizarroids/settings/engine'
require 'bizarroids/settings/config_error'

module Bizarroids
  module Settings
    VALUE_TYPES = %w(string integer float boolean text date datetime file).freeze

    def self.get key
      raise ActiveRecord::RecordNotFound.new("Option ':#{key}' not defined") unless key.in? keys
      Option.find_by!(key: key).try :get_value
    end

    def self.set key, value
      raise ActiveRecord::RecordNotFound.new("Option ':#{key}' not defined") unless key.in? keys
      Option.find_by!(key: key).set_value value
    end

    class << self
      alias :[] :get
      alias :[]= :set
    end

    mattr_accessor :options
    @@options = {}

    mattr_accessor :keys
    @@keys = []

    mattr_accessor :parent_controller
    @@parent_controller = '::ApplicationController'

    def self.setup
      yield self
    end

    private

    def self.option key, type, attrs={}
      key = key.to_sym
      type = type.to_sym
      attrs = attrs.dup

      if options.has_key? key
        raise ConfigError.new "Option ':#{key}' already exists"
      end

      if attrs[:required] && attrs[:value].blank?
        raise ConfigError.new "You must specify :value with required: true"
      end

      if attrs[:hidden] && attrs[:value].blank?
        raise ConfigError.new "You must specify :value with hidden: true"
      end

      if attrs[:collection].present? && !attrs[:collection].kind_of?(Array)
        raise ConfigError.new ":collection option must be an array"
      end

      options[key] = attrs.merge type: type
      keys << key

      # skip creating if table is not exists
      return unless ActiveRecord::Base.connection.table_exists? Option.table_name

      attrs[:collection] = !!attrs[:collection]
      attrs[:position] = keys.index(key)

      option = Option.find_by key: key

      if option.present?
        if option.value_type.to_sym != type
          # replace option if type changed
          option.destroy
          option = nil
        else
          option.update_attributes attrs_for_update(attrs)
          return option
        end
      end

      if option.blank?
        option = Option.create! attrs_for_create(key, type, attrs)
      end

      option
    end

    def self.attrs_for_create key, type, attrs
      attrs.merge(key: key, value_type: type).slice *valid_attr_names
    end

    def self.attrs_for_update attrs
      attrs.slice *auto_update_attr_names
    end

    def self.auto_update_attr_names
      %i(name description required hidden collection position)
    end

    def self.valid_attr_names
      auto_update_attr_names + %i(key value_type value)
    end
  end
end
