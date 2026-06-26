class CreateClients < ActiveRecord::Migration[8.1]
  def change
    create_table :clients do |t|
      t.references :agency, null: false, foreign_key: true

      t.string :business_name, null: false
      t.string :owner_name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :instagram_url

      t.integer :source, null: true
      t.string :source_detail

      t.integer :kind, null: false, default: 0

      t.datetime :converted_at

      t.timestamps
    end
  end
end
