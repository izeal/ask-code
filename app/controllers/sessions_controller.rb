class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user && User.authenticate(params[:email], params[:password])
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
    @current_user = nil
    redirect_to root_path
  end
end
