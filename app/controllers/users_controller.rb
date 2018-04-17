class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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
  end

  def index
    @users = User.all
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
    params.require(:user).permit(
      :name, :login, :email, :password, :password_confirmation
    )
  end

  def find_user
    @user = User.find(params[:id])
  end
end
