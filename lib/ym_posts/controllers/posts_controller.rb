module YmPosts::PostsController
  
  def self.included(base)
    base.expose(:post)
    base.expose(:posts) {Post.page(params[:page])}
    base.expose(:top_tags) {Tag.scoped}
  end
  
  def create
    post.user = current_user
    post.save
  end
  
end