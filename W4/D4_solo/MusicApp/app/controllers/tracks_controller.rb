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
      redirect_to album_url(@track.album)
    else
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.order('title')
    @album = @track.album
    
    if logged_in?
      render :edit
    else
      redirect_to new_session_url
    end
  end

  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      redirect_to album_url(@track.album)
    else
      render :edit
    end
  end

  def show
    @track = Track.find(params[:id])
    @album = @track.album

    render :show
  end

  def destroy
    @track = Track.find(params[:id])

    if logged_in?
      @track.destroy
      redirect_to album_url(@track.album)
    else
      redirect_to new_session_url
    end
  end

  private
  def track_params
    params.require(:track).permit(:album_id, :title, :ord, :lyrics, :bonus)
  end
end
