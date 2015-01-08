class CatsController < ApplicationController
  before_action :check_cat_owner, only: [:edit, :update]

  def check_cat_owner
    @cat = Cat.find(params[:id])
    if @cat.user != current_user
      redirect_to cats_url
    end
  end

  def index
    @cats = Cat.all

    render :index
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    @cat.save

    redirect_to cat_url(@cat)
  end

  def show
    @cat = Cat.find(params[:id])

    render :show
  end

  def edit
    render :edit
  end

  def update
    @cat.update(cat_params)

    redirect_to cat_url(@cat)
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :birth_date, :sex, :color, :description)
  end
end
