class Account::PostsController < ApplicationController


  before_action :authenticate_user!
  before_action :find_group_and_check_permission, only: [:edit, :destroy]
  def index
    @posts = current_user.posts
  end

  def edit

  end

  def update  

    if @post.update(post_params)
      redirect_to account_posts_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:alert] = "Group deleted"
    redirect_to account_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def find_group_and_check_permission
    @post = Post.find(params[:id])

    if current_user != @post.user
      redirect_to root_path, alert: "You have no permission."
    end
  end  

end
