class MemsLoginController < ApplicationController
  
  layout 'mems_landing'

  def index
  	#display text and images
  end

  def login
  	#login form
  end

  def attempt_login
  	 if params[:username].present? && params[:password].present?
      found_user = Users.where(:username => params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user && authorized_user.is_active
      # mark user as logged in
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      flash[:notice] = "Login Successful!"
      redirect_to(:action => 'index')
      else  
      flash[:notice] = "Invalid username/password please re-enter."
      redirect_to(:action => 'login')
    end
  end

  def logout
  	 # mark user as logged out
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

end
