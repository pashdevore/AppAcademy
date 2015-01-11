class BandsController < ApplicationController

  def index
    @bands = Band.order('name')

    render :index
  end

  def new
    @band = Band.new

    if logged_in?
      render :new
    else
      redirect_to new_session_url
    end
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to bands_url
    else
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])

    render :edit
  end

  def update
    @band = Band.find(params[:id])

    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      render :edit
    end
  end

  def show
    @band = Band.find(params[:id])

    render :show
  end

  def destroy

  end

  private
  def band_params
    params.require(:band).permit(:name)
  end
end
