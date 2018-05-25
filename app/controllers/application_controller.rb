class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :author_of

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def reject_user
    redirect_to root_path, alert: t('controllers.application.reject')
  end

  def author_of(post)
    User.find_by(id: post.author_id)
  end

  def find_hashtag_in(model)
    model.text.scan(/#\p{L}+/i).each do |hashtag|
      model.hashtags.create!(tag: hashtag)
    end
  end

  def find_posts_with(tag)
    hashtags = Hashtag.includes(:comment).where(tag: tag)
    (hashtags.map(&:post).compact + hashtags.map(&:comment).compact.map(&:post)).uniq
  end
end
