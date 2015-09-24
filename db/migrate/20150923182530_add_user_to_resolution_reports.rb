class AddUserToResolutionReports < ActiveRecord::Migration
  def change
    add_reference :resolution_reports, :user, index: true, foreign_key: true
  end
end
