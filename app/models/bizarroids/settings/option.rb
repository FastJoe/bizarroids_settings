module Bizarroids::Settings
  class Option < ActiveRecord::Base
    validates :key, presence: true, uniqueness: true
    validates :value_type, presence: true, inclusion: { in: Bizarroids::Settings::VALUE_TYPES }
    validates_presence_of :value, if: :required?

    scope :visible, -> { where hidden: false }
    scope :actual, -> { where key: Bizarroids::Settings.keys }
    scope :default_order, -> { order :position }

    def get_value
      case value_type
      when 'file'
        NotImplementedError
      else
        self[:"#{value_type}_value"]
      end
    end

    def set_value val
      update_attributes value: val
    end

    def avaliable_values
      Bizarroids::Settings.options[key.to_sym][:collection]
    end

    attr_accessor :value

    before_validation do
      self.value_type = self.value_type.to_s

      case value_type
      when 'file'
        raise NotImplementedError
      else
        send :"#{value_type}_value=", self.value
      end
    end
  end
end
