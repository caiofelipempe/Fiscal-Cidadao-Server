class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|

      t.timestamps null: false
      t.belongs_to :user, index: true, foreign_key: true
    end
  end
end
