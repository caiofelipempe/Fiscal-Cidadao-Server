class IssueReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :issue

  has_one :resolution_report, :dependent => :delete

  has_attached_file :image, styles: { thumb: "100x100>" }, :dependent => :delete
  validates_attachment :image, :content_type => { :content_type => 'image/jpeg' }, :size => { :in => 0..5000.kilobytes }

  has_attached_file :video, :processors => [:transcoder], :dependent => :delete
  validates_attachment :video, :time => 10, :content_type => { :content_type => 'video/quicktime' }, :size => { :in => 0..1000.kilobytes }

end
