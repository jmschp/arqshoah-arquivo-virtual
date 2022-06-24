class CreateEducationSupporters < ActiveRecord::Migration[7.0]
  def change
    create_table :education_supporters do |t|
      t.references :donor, null: false, polymorphic: true
      t.references :education, null: false, foreign_key: true

      t.timestamps
    end
  end
end
