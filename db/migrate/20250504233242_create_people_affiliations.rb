class CreatePeopleAffiliations < ActiveRecord::Migration[8.0]
  def change
    create_table :people_affiliations do |t|
      t.references :person, null: false, foreign_key: true
      t.references :affiliation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
