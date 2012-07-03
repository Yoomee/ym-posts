module YmPosts::UserExt
  
  def self.included(base)
    base.has_many :posts, :order => "created_at DESC"
    base.has_many :comments
  end
  
  def wall_posts
    ::Post.for_wall(self)
  end
  
end
