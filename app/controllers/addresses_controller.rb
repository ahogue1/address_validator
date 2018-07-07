class AddressesController < ApplicationController
  def index
    render 'new'
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)

    AddressService.new.parse_street_address(@address)
    @address.save

    render 'new'
  end

  private

  def address_params
    params.permit(:city, :state, :street_address).merge(zip_5: params[:zip_code])
  end
end
