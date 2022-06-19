class CreateIconographies < ActiveRecord::Migration[7.0]
  def change
    create_table :iconographies do |t|
      t.string :registration
      t.string :title, null: false
      t.string :subtitle
      t.date :date
      t.integer :date_day
      t.integer :date_month
      t.integer :date_year
      t.string :location
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :state
      t.string :country
      t.boolean :original
      t.references :donor, polymorphic: true
      t.references :iconography_type, null: false, foreign_key: true
      t.references :iconography_technic, null: false, foreign_key: true
      t.references :iconography_support, null: false, foreign_key: true
      t.references :author, foreign_key: { to_table: :people }
      t.tsvector :document_ts_vector

      t.timestamps
    end

    add_index :iconographies, :document_ts_vector, using: :gin
  end
end
