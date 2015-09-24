class ResolutionReport < ActiveRecord::Base
  belongs_to :issue_report
  belongs_to :user

  validates :user,          presence: true
  validates :issue_report,  presence: true
  validates :description,   presence: true

  has_attached_file :image, styles: { small: "64x64#", med: "100x100#", large: "200x200#" }, :dependent => :delete
  validates_attachment :image, :content_type => { :content_type => 'image/jpeg' }, :size => { :in => 0..1000.kilobytes }
end
