class AlbumsController < ApplicationController

  def new
    @album = Album.new
    @bands = Band.order('name')
    @band = Band.find(params[:band_id])

    if logged_in?
      render :new
    else
      redirect_to new_session_url
    end
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to band_url(@album.band_id)
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

  def show
    @album = Album.find(params[:id])

    render :show
  end

  def destroy

  end

  private
  def album_params
    params.require(:album).permit(:band_id, :title, :year, :live)
  end
end
