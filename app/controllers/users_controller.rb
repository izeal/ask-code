class UsersController < ApplicationController
  before_action :find_user, except: [:new, :create, :index]
  before_action :check_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    default_avatar(@user)
    if @user.save
      flash[:success] = "Вы успешно зарегистрировались"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:danger] = "Корректно заполните все поля"
      render 'new'
    end
  end

  def show
    @post = @user.posts.build
    @posts = @user.posts.select(&:persisted?).sort_by(&:created_at).reverse
    @posts_count = @user.posts.count
    @answers_count = @user.posts.where.not(answer: nil).count
    @unanswered_count = @posts_count - @answers_count
  end

  def index
    @users = User.order("RANDOM()").limit(77)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Данные успешно обновлены"
    else
      flash.now[:danger] = "Мы не смогли обновить ваш профиль по следующим причинам:"
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "Пользователь успешно удален"
    redirect_to users_path
  end

  private

  def user_params
    if current_user && params[:id] == current_user.id
      params.require(:user).permit(
        :name, :login, :email, :header_background_color, :password, :password_confirmation
      )
    else
      params.require(:user).permit(
        :name, :avatar_url, :login, :email, :header_background_color, :password, :password_confirmation
      )
    end
  end

  def find_user
    @user ||= User.find(params[:id])
  end

  def default_avatar(user)
    user.avatar_url ||= ActionController::Base.helpers.asset_path("avatar#{rand(1..5)}.jpg")
  end

  def check_user
    reject_user unless current_user == @user
  end
end
