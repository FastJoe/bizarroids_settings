module Bizarroids::Settings
  class Option < ActiveRecord::Base
    validates :key, presence: true, uniqueness: true
    validates :value_type, presence: true, inclusion: { in: Bizarroids::Settings::VALUE_TYPES }

    mount_uploader :file_value, ::Bizarroids::Settings::OptionUploader

    def self.active_attr attr_name
      :"#{attr_name}_value"
    end

    Bizarroids::Settings::VALUE_TYPES.each do |type|
      # validates :string_value, presence: true, if: "value_type == 'string' && required?"
      validates self.active_attr(type), presence: true, if: "value_type == '#{type}' && required?"
    end

    scope :visible, -> { where hidden: false }
    scope :actual, -> { where key: Bizarroids::Settings.keys }
    scope :user_editable, -> { actual.visible }
    scope :default_order, -> { order :position }
    default_scope -> { default_order }

    def to_param
      key
    end

    def sym_key
      key.to_sym
    end

    def active_attr
      self.class.active_attr value_type
    end

    def get_value
      send active_attr
    end

    def set_value val
      update_attributes value: val
    end

    def avaliable_values
      Bizarroids::Settings.options[sym_key][:collection]
    end

    def human_name
      name || key.humanize
    end

    def human_type
      I18n.t value_type, scope: 'bizarroids.settings.types'
    end

    attr_accessor :value

    before_validation do
      self.value_type = self.value_type.to_s

      if value.present?
        send :"#{active_attr}=", self.value
      end
    end
  end
end
