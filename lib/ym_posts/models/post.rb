module YmPosts::Post
  
  def self.included(base)
    base.belongs_to(:user)
    base.belongs_to(:target, :polymorphic => true)
    base.image_accessor(:image)
    base.validates_presence_of(:user)
    base.validate(:has_content)
    base.send(:default_scope, base.order("created_at DESC"))
    base.scope :for_wall, (lambda do |target|
      conditions = "(target_type = :target_type AND target_id=:target_id)"
      conditions << " OR user_id = :target_id" if target.is_a?(User)
      base.where([conditions, {:target_type => target.class.to_s, :target_id => target.id}])
    end)
  end
  
  private
  def has_content
    if text.blank? && image.nil?
      errors.add(:text, "can't be blank")
    end
  end
  
end