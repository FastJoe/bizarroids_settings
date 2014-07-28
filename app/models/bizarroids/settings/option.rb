module Bizarroids::Settings
  class Option < ActiveRecord::Base
    validates :key, presence: true, uniqueness: true
    validates :value_type, presence: true, inclusion: { in: Bizarroids::Settings::VALUE_TYPES }
    validates_presence_of :value, if: :required?

    scope :visible, -> { where hidden: false }
    scope :actual, -> { where key: Bizarroids::Settings.keys }
    scope :user_editable, -> { actual.visible }
    scope :default_order, -> { order :position }
    default_scope -> { default_order }

    def to_param
      key
    end

    def active_attr
      :"#{value_type}_value"
    end

    def get_value
      case value_type
      when 'file'
        NotImplementedError
      else
        self[active_attr]
      end
    end

    def set_value val
      update_attributes value: val
    end

    def avaliable_values
      Bizarroids::Settings.options[key.to_sym][:collection]
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
        case value_type
        when 'file'
          raise NotImplementedError
        else
          send :"#{active_attr}=", self.value
        end
      end
    end
  end
end
