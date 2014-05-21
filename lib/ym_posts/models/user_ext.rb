module YmPosts::UserExt
  
  def self.included(base)
    base.has_many(:posts, -> { order(:created_at => :desc) }, :dependent => :destroy)
    base.has_many(:comments, :dependent => :destroy)
  end
  
  def wall_posts
    ::Post.for_wall(self)
  end
  
end
