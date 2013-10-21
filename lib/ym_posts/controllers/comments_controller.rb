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
  
end