class CreateIconographyTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :iconography_types do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :iconography_types, :name, unique: true
  end
end
