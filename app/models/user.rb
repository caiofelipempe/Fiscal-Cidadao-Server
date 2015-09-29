class User < ActiveRecord::Base
  before_create :check_admin

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :issue_reports
  has_one :admin, :dependent => :delete

  has_attached_file :image, styles: { small: "64x64#", med: "100x100#", large: "200x200#" }, :dependent => :delete
  validates_attachment :image, :content_type => { :content_type => 'image/jpeg' }, :size => { :in => 0..1000.kilobytes }

  validates :login, uniqueness: true, format: { without: /@/ }

  def check_admin
        if !(Admin.exists?) && !(User.exists?)
          admin = Admin.new
          admin.user = self
        end
    end
end
