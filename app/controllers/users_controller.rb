class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Вы успешно зарегистрировались"
      redirect_to users_path
    else
      flash[:danger] = "Корректно заполните все поля"
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.new
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user), notice: "Данные успешно обновлены"
    else
      render edit_user(@user), notice: "Мы не смогли обновить ваш профиль по следующим причинам:"
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = "Пользователь успешно удален"
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(
      :name, :login, :email, :password, :password_confirmation
    )
  end
end
