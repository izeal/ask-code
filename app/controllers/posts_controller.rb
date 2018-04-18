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
    @post = Post.find_by(id: params[:id])
    if @post.update_attributes(text: params[:post][:text])
      flash[:success] = "Пост обновлен"
    else
      flash[:danger] = "Текст поста не может превышать
                        255 символов либо быть пустым"
    end
      redirect_to user_path(@post.user)
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @post.destroy
    flash[:success] = "Пост удален"
    redirect_to user_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :text)
  end
end
