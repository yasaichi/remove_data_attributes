$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "remove_data_attributes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "remove_data_attributes"
  s.version     = RemoveDataAttributes::VERSION
  s.authors     = ["yasaichi"]
  s.email       = ["yasaichi@users.noreply.github.com"]
  s.homepage    = "https://github.com/yasaichi/remove_data_attributes"
  s.summary     = "Rails plugin for removing data attributes from views"
  s.description = "Rails plugin enables you to remove data attributes automatically from views."
  s.license     = "MIT"

  s.files = Dir["CHANGELOG.md", "{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.0.0"

  s.add_development_dependency "appraisal"
  s.add_development_dependency "reek"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "sqlite3"
end
