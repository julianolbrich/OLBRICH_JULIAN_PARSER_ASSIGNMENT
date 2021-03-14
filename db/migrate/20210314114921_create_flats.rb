class CreateFlats < ActiveRecord::Migration[6.0]
  def change
    create_table :flats do |t|
      t.string :street_number
      t.string :street
      t.string :district
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
