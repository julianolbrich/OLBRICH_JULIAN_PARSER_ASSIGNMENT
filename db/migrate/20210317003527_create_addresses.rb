class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :input
      t.string :address
      t.string :street
      t.string :number
      t.string :number_full
      t.string :plz
      t.string :city
      t.string :addresszusatz

      t.timestamps
    end
  end
end
