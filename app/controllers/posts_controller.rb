class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]



  def index
    @post = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
   @post = current_user.posts.build(post_params)

   if @post.save
     flash[:success] = "Your post has been created!"
     redirect_to posts_path
   else
     flash[:alert] = "Your post couldn't be created!  Please try again."
     render :new
   end
 end

  def edit
    flash.now[:success] = "Post was edited successfully."
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to posts_path
    else
      flash.now[:alert] = "Update failed. Please try again."
      render :edit
    end
  end

  def show

  end

  def destroy
    @post.destroy
    flash[:success] = "Your post was deleted."
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That's not-cho cheese!"
      redirect_to root_path
    end
  end
end
