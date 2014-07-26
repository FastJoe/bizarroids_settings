Bizarroids::Settings.setup do |config|
  # avaliable option types
  config.option :string_option, :string, value: 'MyString'
  config.option :integer_option, :integer, value: 0
  config.option :float_option, :float, value: 0.0
  config.option :boolean_option, :boolean, value: true
  config.option :date_option, :date, value: Date.today
  config.option :datetime_option, :datetime, value: Time.now

  # coming soon
  # config.option :file_option, :file

  # collection option suggests user an array of values to choose from
  config.option :string_collection, :string, collection: %w(white red black)

  # this option will not be visible by user in admin panel
  config.option :hidden_option, :string, value: 'MyString', hidden: true

  # option with required flag prevents user to set empty value
  # it requires value to be set in config
  config.option :required_option, :string, value: 'MyString', required: true

  # description and human readable name can be set
  config.option :user_friendly_option, :string, value: 'MyString', name: 'User friendly', description: 'Option for user'
end
