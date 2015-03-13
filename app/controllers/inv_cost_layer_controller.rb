class InvCostLayerController < ApplicationController
  
  layout 'mems'

  before_action :confirm_logged_in
  
  before_action :confirm_page_access

  def index
  end

  def show
  	@company = params[:company]
  	@procure = params[:procure]
  	@invlayers = InvCostLayers.where(lotserial: params[:lot], active: 1) 
  	@lotnumber = params[:lot]
  	@itemnumber = params[:item_number]

  	respond_to do |format|
		format.html
		format.xls
	end
  end

  private

def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id],
                                             :company => params[:company],  
                                             :module => 'inventory',
                                             :sub_module => 'invcostlayers',
                                             :access_page => 'summary').first
      unless found_page_access
         flash[:notice] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems_login', :action => 'index.html')
      return false
      else return true
      end
 end
end
