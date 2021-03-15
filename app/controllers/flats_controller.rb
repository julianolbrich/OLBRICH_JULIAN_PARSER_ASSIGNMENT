class FlatsController < ApplicationController

  def index
    # def index
    #   @flat = Flat.find_by(address: params[:address]) || Flat.create(address: params[:address])
    # end


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

  # def index
  #   if params[:search].present?
  #     @locations = Location.near(params[:search], 50, :order => "distance")
  #   else
  #     @locations = Location.all
  #     @geojson = Array.new

  #     @locations.each do |location|
  #       @geojson << {
  #           geometry: {
  #             coordinates: [location.longitude, location.latitude],
  #             type: 'Point'
  #           },
  #           id: location.id,
  #           properties:{
  #             title: location.address,
  #             :'marker-color' => '#3887be',
  #             :'marker-symbol' => 'embassy',
  #             :'marker-size' => 'medium'
  #           },
  #           type: 'Feature'
  #       }
  #     end

  #     respond_to do |format|
  #       format.html
  #       format.json { render json: @geojson }  # respond with the created JSON object
  #     end

  #   end
  # end

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

  # def create
  #   @flat = Flat.new(flat_params)

  #   respond_to do |format|
  #     if @flat.save
  #       format.html { redirect_to @flat, notice: 'Flat was successfully created.' }
  #       format.json { render :show, status: :created, location: @flat }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @flat.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def update
  #   respond_to do |format|
  #     if @flat.update(flat_params)
  #       format.html { redirect_to @flat, notice: 'Flat was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @flat }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @flat.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private

  def flat_params
    params.require(:flat).permit(:street_number, :street, :district, :city, :state, :country)
    params.require(:flat).permit(:address)
  end
end
