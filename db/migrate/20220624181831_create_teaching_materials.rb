class CreateTeachingMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :teaching_materials do |t|
      t.string :title, null: false
      t.integer :publication_year, null: false
      t.integer :pages
      t.integer :recording_hours
      t.string :recording_link
      t.references :education, null: false, foreign_key: true
      t.references :teaching_material_type, null: false, foreign_key: true
      t.references :publishing_company, null: false, foreign_key: { to_table: :organizations }

      t.timestamps
    end
  end
end
