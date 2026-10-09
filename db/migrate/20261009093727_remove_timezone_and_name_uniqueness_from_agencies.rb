class RemoveTimezoneAndNameUniquenessFromAgencies < ActiveRecord::Migration[8.1]
  def change
    remove_column :agencies, :timezone, :string, null: false
    remove_index :agencies, :name, unique: true
  end
end
