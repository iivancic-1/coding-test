class CreatePeopleLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :people_locations do |t|
      t.references :person, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
