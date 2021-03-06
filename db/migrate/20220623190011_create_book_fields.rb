class CreateBookFields < ActiveRecord::Migration[7.0]
  def change
    create_table :book_fields do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :book_fields, :name, unique: true
  end
end
