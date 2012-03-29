$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ym_posts/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ym_posts"
  s.version     = YmPosts::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of YmPosts."
  s.description = "TODO: Description of YmPosts."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "ym_users"
  s.add_dependency "ym_tags"
  s.add_dependency "jquery-rails"
  s.add_dependency 'remotipart', '~> 1.0'
  s.add_dependency 'video_info'
  
end
