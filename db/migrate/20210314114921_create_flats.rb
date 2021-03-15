class CreateFlats < ActiveRecord::Migration[6.0]
  def change
    create_table :flats do |t|
      t.string :address, null: false
      t.string :formatted_address
      t.string :street_number
      t.string :street
      t.string :postal_code
      t.string :district
      t.string :city
      t.string :state
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
