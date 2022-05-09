class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :location
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
