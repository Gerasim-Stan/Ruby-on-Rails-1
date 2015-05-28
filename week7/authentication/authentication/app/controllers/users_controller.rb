class UsersController < ApplicationController
  def index
    @users = User.all 
    render 'users/index'
  end

  def new
    @user = User.new 
  end

  def show
    @user = User.find params[:id]
  end

  def create
    if params[:user][:password_hash] == params[:user][:password_confirmation]
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
      create_user
      render '../welcome'
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
      render 'users/new'
    end
  end

  def login
    render 'users/sign_in'
  end

  def logout
    render plain: session.keys
    # session.fetch params[:id] = nil
    # render('./welcome') and return
  end

  def sign_in
    @user = User.find_by_email(params[:user][:email])
    if @user
      if @user.password == params[:user][:password_hash]
        flash[:notice] = "You signed in successfully"
        session[params[authenticity_token]] = @user.id if params[:remember_me] == 1
      end
    end
    @users = User.all
    render 'users/index'
  end

  private

  def create_user
    params[:user].permit!
    @user = User.new(params[:user])
    @user.password = params[:user][:password_hash]
    @user.save!
  end
end