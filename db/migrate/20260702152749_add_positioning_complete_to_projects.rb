class AddPositioningCompleteToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :positioning_complete, :boolean, null: false, default: false
  end
end
