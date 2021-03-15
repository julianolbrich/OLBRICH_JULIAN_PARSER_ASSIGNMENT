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
        lat: flat.latitude,
        infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat}) }
      }
    end
  end

  def show
    @flat = Flat.find(params[:id])
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    if @flat.save
      redirect_to flats_path
    else
      render :new
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:street_number, :street, :district, :city, :state, :country)
  end
end
