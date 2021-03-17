json.array! @addresses do |address|
  json.extract! address, :address #:id, :name
end
