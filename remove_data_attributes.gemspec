$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "remove_data_attributes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "remove_data_attributes"
  s.version     = RemoveDataAttributes::VERSION
  s.authors     = ["yasaichi"]
  s.email       = ["yasaichi@users.noreply.github.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RemoveDataAttributes."
  s.description = "TODO: Description of RemoveDataAttributes."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.3"

  s.add_development_dependency "sqlite3"
end
