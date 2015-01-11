class TracksController < ApplicationController

  def new
    @track = Track.new
    @albums = Album.order('title')
    @album = Album.find(params[:album_id])

    if logged_in?
      render :new
    else
      redirect_to new_session_url
    end
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to album_url(@track.album_id)
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

  def show
    @track = Track.find(params[:id])

    render :show
  end

  def destroy

  end

  private
  def track_params
    params.require(:track).permit(:album_id, :title, :ord, :lyrics, :bonus)
  end
end
