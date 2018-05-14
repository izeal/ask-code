class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find(params[:id])
    @posts = find_posts_with(@hashtag.tag)
  end
end
