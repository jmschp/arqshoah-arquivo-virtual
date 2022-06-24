class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :registration
      t.string :title, null: false
      t.string :subtitle
      t.integer :edition
      t.string :isbn
      t.integer :pages
      t.integer :publishing_year
      t.string :location
      t.string :city
      t.string :state
      t.string :country
      t.float :latitude
      t.float :longitude
      t.references :book_category, null: false, foreign_key: true
      t.references :book_field, null: false, foreign_key: true
      t.references :language, foreign_key: true
      t.references :publishing_company, foreign_key: { to_table: :organizations }
      t.tsvector :document_ts_vector

      t.timestamps
    end
  end
end
