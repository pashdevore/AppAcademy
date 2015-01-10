class PostsController < ApplicationController

  def new
    @post = Post.new

    render :new
  end

  def edit
    @post = Post.find(params[:id])

    render :edit
  end

  def create
    @post = Post.new(post_params)
    @sub = Sub.find(params[:sub_id])

    @post.sub_id = @sub.id
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      @post = Post.new
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])

    render :show
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
