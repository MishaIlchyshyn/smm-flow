class CreateContentPlanItems < ActiveRecord::Migration[8.1]
  def change
    create_table :content_plan_items do |t|
      t.references :project, null: false, foreign_key: true
      t.integer :platform, null: false
      t.integer :content_type, null: false
      t.string :title, null: false
      t.date :scheduled_for, null: false
      t.integer :status, null: false, default: 0
      t.text :caption_draft
      t.text :visual_notes

      t.timestamps
    end
  end
end
