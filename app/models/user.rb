class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :image, styles: { small: "64x64#", med: "100x100#", large: "200x200#" }, :dependent => :delete

  validates_attachment :image, :content_type => { :content_type => 'image/jpeg' }, :size => { :in => 0..1000.kilobytes }
  validates_format_of :login, without: /@/
end
