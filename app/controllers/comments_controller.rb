class CommentsController < ApplicationController
  before_action :find_post, only: [:new, :create, :destroy, :edit, :update]

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      find_hashtag_in(@comment)
      flash[:success] = "Комментарий написан"
      redirect_to user_path(@post.user)
    else
      flash[:danger] = "Текст комментария не может превышать
                        255 символов либо быть пустым"
      render 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = "Пост обновлен"
      redirect_to user_path(@post.user)
    else
      flash[:danger] = "Текст ответа не может превышать
                        255 символов либо быть пустым"
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @user = @comment.user
    @comment.destroy
    flash[:success] = "Ответ удален"
    redirect_to user_path(@user)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
