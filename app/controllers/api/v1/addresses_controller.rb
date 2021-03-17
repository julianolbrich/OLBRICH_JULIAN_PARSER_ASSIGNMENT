class Api::V1::AddressesController < Api::V1::BaseController

  def index
    @addresses = Address.all
  end

  def show
    @address = Address.find(params[:id])
  end

  def create
    @address = Flat.new(address_params)
    if @address.save
      render :show, status: :created
    else
      render_error
    end
  end

end
