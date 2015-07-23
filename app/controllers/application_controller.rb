class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def confirm_logged_in
    unless session[:user_id]
      flash[:alert] = "Please log in."
      redirect_to(:controller => 'mems', :action => 'login')
      return false # halts the before_action
    else
      return true
    end
  end

# def confirm_page_access
#      found_page_access = UserSecurity.where(:userid => session[:user_id], 
#                                             :module => @page_module,
#                                             :sub_module => @page_sub_module).first
      # :sub_module => @page_sub_module
#     unless found_page_access
#         flash[:notice] = "You do not have access to the requested page." 
#         redirect_to(:controller => 'mems_login', :action => 'index.html')
#     return false
#      else return true
#      end
#  end

end
