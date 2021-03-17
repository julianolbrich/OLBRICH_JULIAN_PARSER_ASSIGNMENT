class Api::V1::AddressesController < Api::V1::BaseController

  def index
    @addresses = Address.all
  end

  def show
    @address = Address.find(params[:id])
  end

end
