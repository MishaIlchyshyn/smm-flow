class DropBrandPositioningsAndContentPlanItems < ActiveRecord::Migration[8.1]
  def change
    drop_table :brand_positionings do |t|
      t.references :project, null: false, foreign_key: true, index: { unique: true }
      t.string :brand_name
      t.string :industry
      t.text :target_audience
      t.text :tone_of_voice
      t.text :goals
      t.text :usp
      t.text :competitors
      t.text :visual_style_notes
      t.text :brand_values, array: true, default: []
      t.text :avoid_topics, array: true, default: []

      t.timestamps
    end

    drop_table :content_plan_items do |t|
      t.references :project, null: false, foreign_key: true
      t.integer :platform, null: false
      t.integer :content_type, null: false
      t.string :title, null: false
      t.datetime :scheduled_for, null: false
      t.integer :status, null: false, default: 0
      t.text :caption_draft
      t.text :visual_notes

      t.timestamps
    end

    remove_column :projects, :positioning_complete, :boolean, null: false, default: false
  end
end
