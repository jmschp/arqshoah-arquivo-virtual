class CreateIconographySupports < ActiveRecord::Migration[7.0]
  def change
    create_table :iconography_supports do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :iconography_supports, :name, unique: true
  end
end
