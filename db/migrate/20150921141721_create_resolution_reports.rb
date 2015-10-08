class CreateResolutionReports < ActiveRecord::Migration
  def change
    create_table :resolution_reports do |t|
      t.belongs_to :issue_report, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.string :description

      t.timestamps null: false
    end
  end
end
