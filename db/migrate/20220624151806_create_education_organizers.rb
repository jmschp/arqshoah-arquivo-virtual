class CreateEducationOrganizers < ActiveRecord::Migration[7.0]
  def change
    create_table :education_organizers do |t|
      t.references :education, null: false, foreign_key: true
      t.references :organizer, null: false, foreign_key: { to_table: :people }

      t.timestamps
    end
  end
end
