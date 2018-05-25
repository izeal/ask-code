class CommentsController < ApplicationController
  before_action :find_post, only: [:new, :create, :destroy, :edit, :update]

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save && check_captcha(@comment)
      find_hashtag_in(@comment)
      flash[:success] = t('controllers.comments.created')
      redirect_to user_path(@post.user)
    else
      flash[:danger] = t('controllers.comments.error')
      render 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      @comment.hashtags.destroy_all
      find_hashtag_in(@comment)
      flash[:success] = t('controllers.comments.updated')
      redirect_to user_path(@post.user)
    else
      flash[:danger] = t('controllers.comments.error')
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @user = @comment.user
    @comment.destroy
    flash[:success] = t('controllers.comments.destroyed')
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
