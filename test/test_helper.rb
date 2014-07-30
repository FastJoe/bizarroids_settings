# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
#if ActiveSupport::TestCase.method_defined?(:fixture_path=)
#  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
#end

class ActiveSupport::TestCase
  def clean_options
    Bizarroids::Settings::Option.destroy_all
    Bizarroids::Settings.options = {}
    Bizarroids::Settings.keys = []
  end

  def create_string_option
    clean_options
    Bizarroids::Settings.setup do |config|
      config.option :string_option, :string, {
        required: false,
        value: 'MyStringValue'
      }
    end
  end

  def create_string_collection_option
    clean_options
    Bizarroids::Settings.setup do |config|
      config.option :string_collection_option, :string, {
        required: false,
        value: 'MyStringValue',
        collection: %w(MyStringValue MyStringValue1 MyStringValue2)
      }
    end
  end

  fixture_path = File.expand_path("../fixtures", __FILE__)
  fixtures :all
end
