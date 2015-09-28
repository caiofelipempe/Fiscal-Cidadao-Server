class IssueReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :issue
  has_many :resolution_reports, :dependent => :delete_all

  has_attached_file :image, styles: { small: "64x64#", med: "100x100#", large: "200x200#" }, :dependent => :delete
  validates_attachment :image, :content_type => { :content_type => 'image/jpeg' }, :size => { :in => 0..5000.kilobytes }
end
