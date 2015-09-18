class CreateIssueReports < ActiveRecord::Migration
  def change
    create_table :issue_reports do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :latitude
      t.float :longitude
      t.string :address
      t.string :description
      t.attachment :image
      t.integer :issue_id

      t.timestamps null: false
    end
  end
end
