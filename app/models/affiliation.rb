class Affiliation < ApplicationRecord
  has_many :people_affiliations, dependent: :destroy
  has_many :people, through: :people_affiliations
end
