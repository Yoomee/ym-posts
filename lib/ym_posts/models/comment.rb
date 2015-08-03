module YmPosts::Comment

  def self.included(base)
    base.belongs_to(:user)
    base.belongs_to(:post)
    # base.send(:default_scope, base.order('created_at DESC'))
    base.validates(:user, :post, :text, :presence => true)
  end

  def to_s
    "#{user}'s comment"
  end

end
