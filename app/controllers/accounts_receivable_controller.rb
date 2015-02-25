class AccountsReceivableController < ApplicationController
layout "mems"

before_action :confirm_logged_in
before_action :confirm_page_access

def index
end

def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'ar',
                                             :sub_module => 'ar_menu').first
      unless found_page_access
         flash[:notice] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems_login', :action => 'index.html')
      return false
      else return true
      end
  end

end
