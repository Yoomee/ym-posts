module YmPosts::CommentsController
  
  def self.included(base)
    base.load_and_authorize_resource :except => :create
  end

  def create
    @comment = current_user.comments.create(params[:comment])
  end

  def destroy
    @comment.destroy
  end
  
  def show
    @post = @comment.post
    render :template => 'posts/show'
  end

end