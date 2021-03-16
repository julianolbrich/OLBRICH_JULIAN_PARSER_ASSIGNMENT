class Flat < ApplicationRecord
  validates :address, presence: true, allow_blank: false, uniqueness: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  after_validation :parse_address, if: :will_save_change_to_address?

  def parse_address
    result = Geocoder.search(address).first || Geocoder.search("Hawaii").first

    # self.formatted_address = result.formatted_address
    self.street_number = result.house_number if result.house_number
    self.street = result.street if result.street
    self.postal_code = result.postal_code if result.postal_code
    self.district = result.suburb if result.suburb
    self.city = result.city
    self.state = result.state
    self.country = result.country
  end
end
