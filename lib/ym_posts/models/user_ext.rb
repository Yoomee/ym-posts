module YmPosts::UserExt
  
  def self.included(base)
    base.has_many :posts, :order => "created_at DESC"
  end
  
  def wall_posts
    Post.for_wall(self)
  end
  
end
