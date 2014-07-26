module Bizarroids
  module Settings
    class Engine < ::Rails::Engine
      isolate_namespace Bizarroids::Settings
    end
  end
end
