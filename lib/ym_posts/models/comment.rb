module YmPosts::Comment
  
  def self.included(base) 
    base.belongs_to(:user)
    base.belongs_to(:post)
    
    # base.send(:default_scope, base.order('created_at DESC'))
    
    base.validates(:user, :post, :text, :presence => true)
  end
  
  def email_users
    users_to_email.each do |user|
      UserMailer.new_comment(self, user).deliver
    end
  end
  
  private
  def users_to_email
    ([post.user] + post.users_that_commented - [user]).uniq
  end
  
end