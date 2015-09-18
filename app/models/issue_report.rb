class IssueReport < ActiveRecord::Base
  belongs_to :user

  has_attached_file :image, styles: { small: "64x64#", med: "100x100#", large: "200x200#" }, :dependent => :delete
  validates_attachment :image, :content_type => { :content_type => 'image/jpeg' }, :size => { :in => 0..10000.kilobytes }
end
