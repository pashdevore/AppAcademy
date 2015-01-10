class SubsController < ApplicationController
  before_action :check_for_moderator, only: [:edit]

  def new
    @sub = Sub.new

    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      @sub = Sub.new
      render :new
    end
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def edit
    @sub = Sub.find(params[:id])

    render :edit
  end

  def index
    @subs = Sub.all

    render :index
  end

  def show
    @sub = Sub.find(params[:id])

    render :show
  end

  def check_for_moderator
    @sub = Sub.find(params[:id])

    unless @sub.moderator_id == current_user.id
      flash.notice = "You must have admin rights"
      redirect_to :back
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
