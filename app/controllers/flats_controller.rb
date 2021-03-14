class FlatsController < ApplicationController

  def index
    # @flats = Flat.all
    # markers need coordinates:
    @flats = Flat.where.not(latitude: nil, longitude: nil)

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @flats.geocoded.map do |flat|
    # @markers = @flats.map do |flat|
      # array of hashes that is passed to the map to display
      # there it will passed as a data-markers attribute and made .to_json
      {
        lng: flat.longitude,
        lat: flat.latitude
      }
    end
  end

  def show
    @flat = Flat.find(params[:id])
  end

end
