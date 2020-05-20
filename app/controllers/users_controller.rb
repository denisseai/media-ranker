class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end
  
  def show
    check_user
  end
  
  def login_form
    @user = User.new
  end
  
  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if username.nil?
      flash[:error] = "A problem occurred: Could not log in username: can't be blank"
      redirect_to login_path
    else
      if user
        session[:user_id] = user.id
        flash[:success] = "Successfully logged in as existing user #{username}"
      else
        user = User.create(username: username)
        session[:user_id] = user.id
        flash[:success] = "Successfully created user #{username} with ID #{user.id}"
      end
      redirect_to root_path
    end
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        flash[:notice] = "Successfully logged out"
        session[:user_id] = nil
      else 
        flash[:notice] = "Error with log out"
        session[:user_id] = nil
      end
    else 
      # Not sure if I'll ever get here
      flash[:error] = "You must be loggined in before to logout"
    end
    redirect_to root_path
  end

  private
  def find_user
    user_id = params[:id].to_i
    @user = User.find_by(id: user_id)
  end

  def check_user
    if @user.nil?
      redirect_to users_path, error: 'User not found'
      return
    end
  end

end