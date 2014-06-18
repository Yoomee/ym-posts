module YmPosts::Comment

  def self.included(base)
    base.belongs_to(:user)
    base.belongs_to(:post)

    # base.send(:default_scope, base.order('created_at DESC'))

    base.validates(:user, :post, :text, :presence => true)
    base.after_save :record_notifications

  end

  def record_notifications
    users_to_notify = [post.user] + post.comments.collect(&:user)
    users_to_notify.uniq!
    users_to_notify = users_to_notify - [user]
    users_to_notify.each { |user| Notification.create(:user => user, :resource => self, :resource_type => 'Comment') }
  end

  def to_s
    "#{user}'s comment"
  end

end
