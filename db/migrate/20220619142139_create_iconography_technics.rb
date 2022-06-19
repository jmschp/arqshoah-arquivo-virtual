class CreateIconographyTechnics < ActiveRecord::Migration[7.0]
  def change
    create_table :iconography_technics do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :iconography_technics, :name, unique: true
  end
end
