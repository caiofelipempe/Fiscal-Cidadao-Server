class ResolutionReport < ActiveRecord::Base
  belongs_to :issue_report
  belongs_to :user

  validates :user,          presence: true
  validates :issue_report,  presence: true
  validates :description,   presence: true
end
