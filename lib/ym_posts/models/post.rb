module YmPosts::Post
  
  def self.included(base)
    base.send(:before_validation, :extract_video_url)
    base.send(:include, YmVideos::HasVideo)
    base.belongs_to(:user)
    base.belongs_to(:target, :polymorphic => true)
    base.has_many(:comments, :dependent => :destroy)
    base.image_accessor(:image)
    base.file_accessor(:file)
    base.validates_presence_of(:user)
    base.send(:validates_property, :format, :of => :image, :in => [:jpeg, :jpg, :png, :gif], :message => "must be an image", :case_sensitive => false)
    base.validates :file, :length => {:maximum => 2.megabytes}, :allow_blank => true
    base.validate(:has_content)
    base.acts_as_taggable
    base.default_scope { order(:created_at => :desc) }
    base.scope :for_wall, (lambda do |target|
      conditions = "(target_type = :target_type AND target_id=:target_id)"
      conditions << " OR user_id = :target_id" if target.is_a?(User)
      base.where([conditions, {:target_type => target.class.to_s, :target_id => target.id}])
    end)
    base.per_page = 10
  end
  
  def file_ext
    file.try(:ext)
  end
  
  def file_path
    file.try(:path)
  end
  
  def to_s
    "#{user}'s post"
  end
  
  private  
  def has_content
    if text.blank? && image.nil? && video_url.blank?
      errors.add(:text, "can't be blank")
    end
  end
  
  def extract_video_url
    if video_url.blank? && text.present?
      if matches = (text.match(YmVideos::YOUTUBE_REGEX) || text.match(YmVideos::VIMEO_REGEX))
        self.video_url = "http://#{matches[0]}"
      end  
    end
  end
  
end
