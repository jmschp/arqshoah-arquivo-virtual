class CreateTeachingMaterialTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :teaching_material_types do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
