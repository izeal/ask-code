class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :author_of

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def reject_user
    redirect_to root_path, alert: 'Вам сюда низя!'
  end

  def author_of(post)
    User.find_by(id: post.author_id)
  end

  def find_hashtag_in(model)
    model.text.scan(/#[a-z]+/i).each do |hashtag|
      model.hashtags.create!(tag: hashtag)
    end
  end
end
