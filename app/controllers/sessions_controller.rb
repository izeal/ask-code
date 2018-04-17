class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:succes] = "#{@user.name}, добро пожаловать"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Неверная комбинация"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
