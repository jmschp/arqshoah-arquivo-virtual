class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives do |t|
      t.date :date
      t.integer :date_day
      t.integer :date_month
      t.integer :date_year
      t.integer :date_mask
      t.string :document_number
      t.string :document_code
      t.tsvector :document_ts_vector
      t.float :latitude
      t.float :longitude
      t.string :location
      t.string :city
      t.string :state
      t.string :country
      t.string :from_name
      t.string :from_role
      t.integer :page_count
      t.string :registration
      t.string :title, null: false
      t.string :to_name
      t.string :to_role

      t.references :archive_classification, foreign: true, null: false
      t.references :archive_type, foreign: true, null: false
      t.references :donor, polymorphic: true
      t.references :language, foreign: true
      t.references :issuing_agency, foreign: { to_table: :organizations }
      t.references :receiver_agency, foreign: { to_table: :organizations }

      t.timestamps
    end

    add_index :archives, :document_ts_vector, using: :gin
    add_index :archives, :title, unique: true
  end
end
