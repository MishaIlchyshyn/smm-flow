class RemoveSlugFromAgencies < ActiveRecord::Migration[8.1]
  def change
    remove_index :agencies, :slug, unique: true
    remove_column :agencies, :slug, :string, null: false
  end
end
