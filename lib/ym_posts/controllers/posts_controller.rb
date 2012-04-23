module YmPosts::PostsController
  
  def self.included(base)
    base.expose(:current_post) {params[:id].present? ? Post.find(params[:id]) : Post.new(params[:post] || {})}
    base.expose(:posts) {Post.page(params[:page])}
    base.expose(:top_tags) {Post.tag_counts_on(:tags, :limit => 10)}
  end
  
  def create
    current_post.user = current_user
    current_post.save
  end
  
  def destroy
    current_post.destroy
  end
  
  def modal
    render :layout => false
  end
  
end