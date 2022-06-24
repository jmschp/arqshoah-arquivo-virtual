class CreateTeachingMaterialAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :teaching_material_authors do |t|
      t.references :author, null: false, foreign_key: { to_table: :people }
      t.references :teaching_material, null: false, foreign_key: true

      t.timestamps
    end
  end
end
