class CreateCitations < ActiveRecord::Migration[7.0]
  def change
    create_table :citations do |t|
      t.references :record, polymorphic: true, null: false
      t.references :person, foreign_key: true, null: false

      t.timestamps
    end
  end
end
