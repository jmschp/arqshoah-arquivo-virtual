class CreateNewspaperTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :newspaper_types do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :newspaper_types, :name, unique: true
  end
end
