class InvLotController < ApplicationController
  

  	before_action :confirm_logged_in
  	before_action :confirm_page_access

    layout "mems"

  def index    
  end

  def show
    @company = params[:company]
    @procure = params[:procure]
    @invlots = InvLots.where(item_masters_id: params[:item_masters_id], active: 1)   
    @itemnumber = params[:item_number] 
    @itemmastersid = params[:item_masters_id]

    respond_to do |format|
        format.html
        format.xls
    end
   end

private

def lot_params
    params.require(:inv_lots).permit(:lot, :item_masters_id, :users_id, :company)
end

def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id],
                                             :company => params[:company],  
                                             :module => 'inventory',
                                             :sub_module => 'invlots',
                                             :access_page => 'summary').first
      unless found_page_access
         flash[:notice] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems_login', :action => 'index.html')
      return false
      else return true
      end
 end
end
