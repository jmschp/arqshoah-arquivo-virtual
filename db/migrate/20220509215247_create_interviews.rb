class CreateInterviews < ActiveRecord::Migration[7.0]
  def change
    create_table :interviews do |t|
      t.date :date
      t.string :location
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :state
      t.string :country

      t.references :interviewer, foreign_key: { to_table: :people }, null: false
      t.references :interviewed, foreign_key: { to_table: :people }, null: false

      t.timestamps
    end
  end
end
