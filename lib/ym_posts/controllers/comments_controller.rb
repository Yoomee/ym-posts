module YmPosts::CommentsController
  
  def create
    if @comment = current_user.comments.create(params[:comment])
      @comment.email_users
    end
  end
  
end