class ProcurementController < ApplicationController
layout "mems"

before_action :confirm_logged_in
before_action :confirm_page_access

def index
end
 

 def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'po',
                                             :sub_module => 'po_menu').first
      unless found_page_access
         flash[:alert] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems', :action => 'login')
      return false
      else return true
      end
  end

end
