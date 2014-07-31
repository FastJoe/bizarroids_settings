class CreateBizarroidsSettingsOptions < ActiveRecord::Migration
  def change
    create_table :bizarroids_settings_options do |t|
      t.string :key

      t.string :value_type, limit: 10
      t.string :name
      t.string :description
      t.boolean :required, default: false
      t.boolean :hidden, default: false
      t.boolean :collection, default: false
      t.integer :position

      # values
      t.string :string_value
      t.integer :integer_value
      t.float :float_value
      t.boolean :boolean_value, default: false
      t.text :text_value
      t.date :date_value
      t.datetime :datetime_value
      t.string :file_value

      t.timestamps
    end

    add_index :bizarroids_settings_options, :key
  end
end
