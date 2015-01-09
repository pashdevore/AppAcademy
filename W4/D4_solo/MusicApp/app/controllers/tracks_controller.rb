class TracksController < ApplicationController

  def new
    @track = Track.new

    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to :back
    else
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])

    render :show
  end

  private
  def track_params
    params.require(:track).permit(:title, :album_id)
  end
end
