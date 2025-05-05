class Location < ApplicationRecord
  has_many :people_locations, dependent: :destroy
  has_many :people, through: :people_locations
end
