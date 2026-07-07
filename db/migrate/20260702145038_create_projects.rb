class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.references :agency, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :status, null: false, default: 0
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
