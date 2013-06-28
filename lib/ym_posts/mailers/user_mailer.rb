module YmPosts::UserMailer

  def new_comment(comment, user)
    @user = user
    @comment = comment
    @name_or_your = comment.post.user == user ? "your" : "#{comment.post.user}'s"
    mail(:to => user.email, :subject => "Someone commented on #{@name_or_your} post")
  end

end