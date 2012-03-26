require "ym_posts/engine"

module YmPosts
end

Dir[File.dirname(__FILE__) + '/ym_posts/models/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/ym_posts/controllers/*.rb'].each {|file| require file }