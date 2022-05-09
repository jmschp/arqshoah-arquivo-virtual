class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :academic_formation
      t.date :birth_date
      t.integer :birth_date_day
      t.integer :birth_date_month
      t.integer :birth_date_year
      t.integer :birth_date_mask
      t.string :birth_place
      t.string :birth_place_city
      t.string :birth_place_state
      t.string :birth_place_country
      t.float :birth_place_latitude
      t.float :birth_place_longitude
      t.date :death_date
      t.integer :death_date_day
      t.integer :death_date_month
      t.integer :death_date_year
      t.integer :death_date_mask
      t.string :death_place
      t.string :death_place_city
      t.string :death_place_state
      t.string :death_place_country
      t.float :death_place_latitude
      t.float :death_place_longitude
      t.tsvector :document_ts_vector
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :name_variation
      t.integer :gender
      t.string :registration
      t.string :type

      t.references :religion, foreign_key: true
      t.references :spouse, foreign_key: { to_table: :people }
      t.references :mother, foreign_key: { to_table: :people }
      t.references :father, foreign_key: { to_table: :people }

      t.timestamps
    end
  end
end
