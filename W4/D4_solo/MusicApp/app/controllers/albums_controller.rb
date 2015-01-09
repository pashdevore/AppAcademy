class AlbumsController < ApplicationController

  def show
    @album = Album.find(params[:id])

    render :show
  end

  def new
    @album = Album.new

    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to :back
    else
      render :new
    end
  end

  def update
    
  end

  private
  def album_params
    params.require(:album).permit(:title, :band_id)
  end
end
