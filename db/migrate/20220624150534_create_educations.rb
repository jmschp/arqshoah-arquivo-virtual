class CreateEducations < ActiveRecord::Migration[7.0]
  def change
    create_table :educations do |t|
      t.string :registration
      t.string :title, null: false
      t.string :target_public
      t.date :start_date
      t.date :end_date
      t.boolean :online, null: false, default: false
      t.string :record_link
      t.references :education_category, null: false, foreign_key: true
      t.references :venue, null: false, foreign_key: { to_table: :organizations }
      t.tsvector :document_ts_vector

      t.timestamps
    end
  end
end
