YmUsers::User.class_eval do

  class << self
    
    def included_with_ym_posts(base)
      included_without_ym_posts(base)
      base.send(:include, YmPosts::UserExt)
    end
    alias_method_chain :included, :ym_posts
    
  end
  
end
