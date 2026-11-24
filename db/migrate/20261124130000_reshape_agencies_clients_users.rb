class ReshapeAgenciesClientsUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :agencies, :name, :string, null: false

    change_table :clients, bulk: true do |t|
      t.remove :business_name, type: :string, null: false
      t.remove :owner_name, type: :string, null: false
      t.remove :phone, type: :string, null: false
      t.remove :instagram_url, type: :string
      t.remove :source, type: :integer
      t.remove :source_detail, type: :string
      t.remove :converted_at, type: :datetime
      t.string :name, null: false
      t.string :website_url
      t.text :notes
    end

    change_column_null :clients, :email, true

    change_table :users, bulk: true do |t|
      t.remove :full_name, type: :string, null: false
      t.remove :avatar_url, type: :string
      t.string :first_name, null: false
      t.string :last_name, null: false
    end
  end
end
