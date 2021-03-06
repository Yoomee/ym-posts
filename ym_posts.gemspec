$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ym_posts/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ym_posts"
  s.version     = YmPosts::VERSION
  s.authors     = ["Matt Atkins", "Ian Mooney", "Si Wilkins"]
  s.email       = ["matt@yoomee.com", "ian@yoomee.com", "si@yoomee.com"]
  s.homepage    = "http://www.yoomee.com"
  s.summary     = "Summary of YmPosts."
  s.description = "Description of YmPosts."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'ym_core', "~> 1.0"
  s.add_dependency "ym_tags", "~> 1.0"
  s.add_dependency "ym_users", "~> 1.0"
  s.add_dependency "ym_videos", "~> 1.0"
  s.add_dependency "jquery-rails"
  s.add_dependency 'remotipart', '~> 1.0'
  s.add_dependency "ym_notifications", "~> 1.0"
  
  # for testing
  s.add_development_dependency "mysql2"    
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"  
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency "capybara", "~> 2.0.3"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "geminabox"
  s.add_development_dependency "ym_tools", '~> 1.0'

end
