class InvLotController < ApplicationController
  
  	before_action :confirm_logged_in
  	before_action :confirm_page_access

    layout "mems"

  def index
    
  end

  private


def lot_params
    params.require(:inv_lots).permit(:lot, :item_masters_id, :users_id)
end

def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'inventory',
                                             :sub_module => 'coils',
                                             :access_page => 'inv_lots').first
      unless found_page_access
         flash[:notice] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems_login', :action => 'index.html')
      return false
      else return true
      end
  end

end
