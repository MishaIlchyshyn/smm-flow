class ReplaceMembershipsWithUsersAgencyId < ActiveRecord::Migration[8.1]
  def change
    add_reference :users, :agency, null: false, foreign_key: true

    drop_table :memberships do |t|
      t.references :agency, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps

      t.index %i[agency_id user_id], unique: true
    end
  end
end
