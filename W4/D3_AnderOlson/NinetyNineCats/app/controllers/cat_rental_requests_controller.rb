class CatRentalRequestsController < ApplicationController
  before_action :check_rental_owner, only:[:approve_or_deny]

  def check_rental_owner
    @rental = CatRentalRequest.find(params[:id])
    if @rental.owner != current_user
      redirect_to cats_url
    end
  end

  def index
    @rentals = CatRentalRequest.all

    render :index
  end

  def new
    @rental = CatRentalRequest.new
    @cats = Cat.all

    render :new
  end

  def create
    @rental = CatRentalRequest.new(rental_params)
    @rental.requester_id = current_user.id
    @rental.save

    redirect_to cat_rental_request_url(@rental)
  end

  def show
    @rental = CatRentalRequest.find(params[:id])

    render :show
  end

  def approve_or_deny
    new_status = params[:new_status]
    if new_status == "Approve"
      @rental.approve!
    elsif new_status == "Deny"
      @rental.deny!
    end

    render :show
  end

  private

  def rental_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end
end
