class CreateBrandPositionings < ActiveRecord::Migration[8.1]
  def change
    create_table :brand_positionings do |t|
      t.references :project, null: false, foreign_key: true, index: { unique: true }

      t.string :brand_name
      t.string :industry
      t.text :target_audience
      t.text :tone_of_voice
      t.text :brand_values, array: true, default: []
      t.text :usp
      t.text :goals
      t.text :competitors
      t.text :avoid_topics, array: true, default: []
      t.text :visual_style_notes

      t.timestamps
    end
  end
end
