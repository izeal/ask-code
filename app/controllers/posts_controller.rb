class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :destroy]
  before_action :check_user, except: [:create]

  def create
    @user = User.find_by(id: params[:post][:user_id])
    @post = @user.posts.build(post_params)
    @post.author = current_user if current_user

    if @post.save
      find_hashtag_in(@post)
      flash[:success] = "Пост создан"
      redirect_to user_path(@user)
    else
      flash[:danger] = "Текст поста не может превышать
                        255 символов либо быть пустым"
    end
  end

  def edit
    @comment = @post.comments.build(params[:comment])
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Пост обновлен"
      redirect_to user_path(@post.user)
    else
      flash[:danger] = "Текст поста не может превышать
                        255 символов либо быть пустым"
      render 'edit'
    end
  end

  def destroy
    @user = @post.user
    @post.destroy
    flash[:success] = "Пост удален"
    redirect_to user_path(@user)
  end

  def check_user
    reject_user unless current_user == @post.author || current_user == @post.user
  end

  private

  def post_params
    if current_user && params[:post][:user_id].to_i == current_user.id
      params.require(:post).permit(:user_id, :text, :author_id)
    else
      params.require(:post).permit(:user_id, :text, :author_id)
    end
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
