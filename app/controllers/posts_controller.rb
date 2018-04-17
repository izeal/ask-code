class PostsController < ApplicationController
  def new
    @post = @user.post.build
  end

  def create
    @user = User.find_by(id: params[:post][:user_id])
    @post = @user.posts.build(post_params)
    if @post.save
      flash[:success] = "Пост создан"
      redirect_to user_path(@user)
    else
      flash[:danger] = "Текст поста не может превышать
                        255 символов либо быть пустым"
    end
  end

  def show
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
    # user = @post.user
    @post.desrtoy
    flash[:success] = "Пост удален"
    redirect_to user_path(user)
  end

  private

  def post_params
    params.require(:post).permit(:text, :user_id)
  end
end
