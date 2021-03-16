class FlatsController < ApplicationController

  def index
    @flats = Flat.all
    @markers = @flats.geocoded.map do |flat|
      {
        lng: flat.longitude,
        lat: flat.latitude,
        infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat}) }
      }
    end

    @flat = Flat.new
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
      respond_to do |format|
        format.html {redirect_to flats_path}
        format.js
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js
      end
    end

  end

  def destroy
    @flat = Flat.find(params[:id])

    if @flat.destroy
      respond_to do |format|
        format.html { redirect_to flats_path }
        format.js
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js
      end
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:address)
  end
end
