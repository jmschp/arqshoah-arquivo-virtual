class CreateBookIconographies < ActiveRecord::Migration[7.0]
  def change
    create_table :book_iconographies do |t|
      t.references :book, null: false, foreign_key: true
      t.references :iconography, null: false, foreign_key: true

      t.timestamps
    end
  end
end
