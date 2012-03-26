module YmPosts::Post
  
  def self.included(base)
    base.belongs_to(:user)
    base.image_accessor(:image)
    base.validates_presence_of(:user)
    base.validate(:has_content)
  end
  
  private
  def has_content
    if text.blank? && image.nil?
      errors.add(:text, "can't be blank")
    end
  end
  
end