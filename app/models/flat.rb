class Flat < ApplicationRecord
  geocoded_by :street && :street_number && :city
  after_validation :geocode, if: :will_save_change_to_street?
end
