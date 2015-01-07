class CatsController < ApplicationController

  def index
    @cats = Cat.all

    render :index
  end

  def show
    @cat = Cat.find(params[:id])

    if @cat
      render :show
    else
      redirect_to cats_url
    end
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      flash.notice = nil
      redirect_to cat_url(@cat)
    else
      flash.notice = "Oh no! #{@cat.errors.full_messages.join(', ')}... Try again."
      render :new
    end
  end

  def new
    @cat = Cat.new

    render :new
  end

  def edit
    @cat = Cat.find(params[:id])

    render :edit
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :color, :birth_date, :description, :sex)
  end

end
