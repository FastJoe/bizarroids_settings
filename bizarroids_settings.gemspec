$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bizarroids/settings/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bizarroids_settings"
  s.version     = Bizarroids::Settings::VERSION.dup
  s.authors     = ["Corlinus"]
  s.email       = ["corlinus@gmail.com"]
  s.homepage    = "https://github.com/corlinus/bizarroids_settings"
  s.summary     = "Bizarroids Settings provides basic user editable settings for Rails"
  s.description = "Bizarroids Settings provides basic user editable settings for Rails"
  s.require_path = "lib"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2"
  s.add_dependency "inherited_resources", "~> 1.7"
  s.add_dependency "simple_form", "~> 3.0.0"
  s.add_dependency "cancancan", "~> 1.9.0"
  s.add_dependency "mini_magick", "~> 3.8"
  s.add_dependency "carrierwave", "~> 0.11"

  s.add_development_dependency "sqlite3"
end
