module YmPosts::UserExt
  
  def self.included(base)
    base.has_many :posts, :order => "created_at DESC"
  end
  
end