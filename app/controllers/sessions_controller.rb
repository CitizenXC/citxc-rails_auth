class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:create, :new]
  before_action :authenticate_user!, only: [:destroy]

  def create
    @user = User.find_by(email: params[:user][:email].downcase)

    if @user
      if @user.unconfirmed?
        redirect_to new_confirmation_path,
          alert: "You must confirm your email before you can sign in."
      elsif @user.authenticate(params[:user][:password])
        login @user
        remember(@user) if params[:user][:remember_me] == "1"
      else
        flash.now[:alert] = "Incorrect email or password."
        render :new
      end
    else
      flash.now[:alert] = "Incorrect email or password."
      render :new
    end
  end

  def destroy
    forget(current_user)
    logout
    redirect_to root_path, notice: "Signed out."
  end

  def new
  end

end
