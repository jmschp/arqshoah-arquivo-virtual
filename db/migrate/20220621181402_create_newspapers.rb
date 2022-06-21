class CreateNewspapers < ActiveRecord::Migration[7.0]
  def change
    create_table :newspapers do |t|
      t.string :registration
      t.string :title, null: false
      t.string :location
      t.string :city
      t.string :state
      t.string :country
      t.string :latitude
      t.string :longitude
      t.date :date
      t.integer :date_day
      t.integer :date_month
      t.integer :date_year
      t.string :print_number
      t.references :newspaper_type, null: false, foreign_key: true
      t.references :author, foreign_key: { to_table: :people }
      t.references :agency, foreign_key: { to_table: :organizations }
      t.references :language, foreign_key: true
      t.tsvector :document_ts_vector

      t.timestamps
    end
  end
end
