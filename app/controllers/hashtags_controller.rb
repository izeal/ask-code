class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(tag: params[:id])
    @posts = find_posts_with(@hashtag.tag)
  end

  def posts
    @hashtag = Hashtag.find_by(tag: params[:hashtag_id])
    @posts = Post.includes(:hashtags).where(hashtags: { tag: @hashtag.tag })
  end
end
