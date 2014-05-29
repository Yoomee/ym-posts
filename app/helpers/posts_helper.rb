module PostsHelper
  def comments_link_text(post)
    post.comments.count.zero? ? 'Write the first comment' : "#{pluralize(post.comments.count, 'user')} commented"
  end
end
