module YmPosts::PostsController

  def self.included(base)
    base.load_and_authorize_resource
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      @new_post = Post.new(:target => @post.target, :user => @post.user)
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def destroy
    @post.destroy
  end

  def file
    send_file(@post.file_path, :filename => @post.file_name)
  end

  def index
    @posts = Post.page(params[:page])
    @top_tags = Post.tag_counts_on(:tags, :limit => 10)
  end

  def modal
    render :layout => false
  end

  def show
  end

  private
  def post_params
    params.require(:post).permit(permitted_post_parameters)
  end

end
