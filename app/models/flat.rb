class Flat < ApplicationRecord
  geocoded_by :street && " " && :street_number && ", " && :city
  # geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_street?
end
