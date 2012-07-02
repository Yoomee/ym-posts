module YmPosts::PostsController
  
  def self.included(base)
    base.expose(:current_post) {params[:id].present? ? Post.find(params[:id]) : Post.new(params[:post] || {})}
    base.expose(:posts) {Post.page(params[:page])}
    base.expose(:top_tags) {Post.tag_counts_on(:tags, :limit => 10)}
  end
  
  def create
    current_post.user = current_user
    if current_post.save
      @new_post = Post.new(:target => current_post.target, :user => current_post.user)
    end
  end
  
  def destroy
    current_post.destroy
  end
  
  def file
    send_file(current_post.file_path, :filename => current_post.file_name)
  end
  
  def modal
    render :layout => false
  end
  
end