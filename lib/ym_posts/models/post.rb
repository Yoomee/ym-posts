module YmPosts::Post
  
  def self.included(base)
    base.belongs_to(:user)
    base.belongs_to(:target, :polymorphic => true)
    base.image_accessor(:image)
    base.send(:attr_accessor, :video_info)
    base.before_validation(:get_video_info)
    base.before_save(:save_video_info)
    base.validates_presence_of(:user)
    base.send(:validates_property, :format, :of => :image, :in => [:jpeg, :jpg, :png, :gif], :message => "must be an image")
    base.validate(:has_content)
    base.validate(:found_video_info)
    base.acts_as_taggable
    base.send(:default_scope, base.order("created_at DESC"))
    base.scope :for_wall, (lambda do |target|
      conditions = "(target_type = :target_type AND target_id=:target_id)"
      conditions << " OR user_id = :target_id" if target.is_a?(User)
      base.where([conditions, {:target_type => target.class.to_s, :target_id => target.id}])
    end)
    base.per_page = 10
  end
  
  def has_video?
    video_url.present?
  end
  
  def video_youtube?
    return false if video_url.blank?
    video_url.match(YmPosts::YOUTUBE_REGEX)
  end
  
  def video_vimeo?
    return false if video_url.blank?
    video_url.match(YmPosts::VIMEO_REGEX)
  end
  
  def video_embed_id
    return nil if video_url.blank?
    if res = video_url.match(YmPosts::YOUTUBE_REGEX)
      res[3]
    elsif res = video_url.match(YmPosts::VIMEO_REGEX)
      res[1]
    end
  end
  
  def video_embed_url
    if video_youtube?
      "http://www.youtube.com/embed/#{video_embed_id}"
    elsif video_vimeo?
      "http://player.vimeo.com/video/#{video_embed_id}?title=0&amp;byline=0&amp;portrait=0&amp;color=ff9933"
    end
  end
  
  def to_s
    "#{user}'s post"
  end
  
  private
  def found_video_info
    if video_info && !video_info.valid?
      errors.add(:video_url, "couldn't find video")
    end
  end
  
  def get_video_info
    if video_url.present?
      self.video_url = "http://#{video_url}" unless video_url =~ /^http/
      self.video_info = VideoInfo.new(video_url)
    end
  end
  
  def has_content
    if text.blank? && image.nil? && video_url.blank?
      errors.add(:text, "can't be blank")
    end
  end
  
  def save_video_info
    if video_info.present?
      self.video_title = video_info.title
      self.video_description = video_info.description
      self.image_url = video_info.thumbnail_large
    end
  end
  
end
YmPosts::YOUTUBE_REGEX = /youtu(.be)?(be.com)?.*(?:\/|v=)([\w-]+)/
YmPosts::VIMEO_REGEX = /.*\.com\/(?:groups\/[^\/]+\/videos\/)?([0-9]+).*$/i