class CatRentalRequestsController < ApplicationController
  def index
    @cat_rental_requests = CatRentalRequest.all

    render json: @cat_rental_requests
  end

  def show
    @crr = CatRentalRequest.find(params[:id])

    render json: @crr
  end


  def new
    @crr = CatRentalRequest.new

    render json: @cat_rental_requests
  end

  def create
    @crr = CatRentalRequest.new(crr_params)

    if @crr.save
      redirect_to cat_rental_requests_url(@crr)
    else
      render json: @cat_rental_requests
    end
  end

  def crr_params
    params.require(:cat_rental_requests).permit(:cat_id, :start_date, :end_date, :status)
  end
end
