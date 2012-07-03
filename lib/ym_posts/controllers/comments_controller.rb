module YmPosts::CommentsController
  
  def create
    @comment = current_user.comments.create(params[:comment])
  end
  
end