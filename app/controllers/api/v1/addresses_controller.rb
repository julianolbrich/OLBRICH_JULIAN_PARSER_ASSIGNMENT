class Api::V1::AddressesController < Api::V1::BaseController

  def index
    @addresses = Flat.all
  end

  def show
    @address = Flat.find(params[:id])
  end

end
