class Person < ApplicationRecord
  has_many :people_locations, dependent: :destroy
  has_many :locations, through: :people_locations

  has_many :people_affiliations, dependent: :destroy
  has_many :affiliations, through: :people_affiliations

  validates :first_name, :species, :gender, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "first_name", "gender", "id", "id_value", "last_name", "species", "updated_at", "vehicle", "weapon", "affiliations", "locations_name" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "affiliations", "locations", "people_affiliations", "people_locations" ]
  end
end
