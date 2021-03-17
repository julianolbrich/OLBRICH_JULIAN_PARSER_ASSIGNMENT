json.array! @addresses do |address|
  json.extract! address, :id, :input, :address, :street, :number, :number_full, :plz, :city, :addresszusatz
end
