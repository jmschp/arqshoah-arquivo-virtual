class AddUniqueIndexes < ActiveRecord::Migration[7.0]
  def change
    add_index :archive_classifications, :name, unique: true
    add_index :archive_types, :name, unique: true
    add_index :languages, :name, unique: true
    add_index :organizations, :name, unique: true
    add_index :religions, :name, unique: true
  end
end
