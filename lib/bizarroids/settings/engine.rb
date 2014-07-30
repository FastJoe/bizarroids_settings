module Bizarroids
  module Settings
    class Engine < ::Rails::Engine
      isolate_namespace Bizarroids::Settings
      ActionView::Base.send :include, Bizarroids::Settings::SettingsHelper
    end
  end
end
