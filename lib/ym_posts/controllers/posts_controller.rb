module YmPosts::PostsController
  
  def self.included(base)
    base.expose(:post)
  end
  
  def create
    post.user = current_user
    post.save
  end
  
end