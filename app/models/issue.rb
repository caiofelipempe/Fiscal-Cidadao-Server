class Issue < ActiveRecord::Base
  has_many :issue_reports, :dependent => :delete_all
  validates :name, uniqueness: true
end
