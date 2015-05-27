class InvCountMasterController < ApplicationController

  layout 'mems'

  before_action :confirm_logged_in
  before_action :confirm_page_access
  
  def create
  end

  def view
  	@countmaster = InvCountMasters.all()
  end

  def edit
  	@countmaster = InvCountMasters.find(params[:id])
  end

  def update
  	@countmaster = InvCountMasters.find(params[:countmaster][:id].to_i)
  	@countmaster.coil_cycle = params[:countmaster][:coil_cycle].to_i
  	@countmaster.misc_cycle = params[:countmaster][:misc_cycle].to_i
  	@countmaster.sheathing_cycle = params[:countmaster][:sheathing_cycle].to_i
  	@countmaster.sheetsteel_cycle = params[:countmaster][:sheetsteel_cycle].to_i
  	@countmaster.is_active = params[:countmaster][:is_active].to_i
    @countmaster.updated_by = session[:user_id]
  	@countmaster.save
  	if @countmaster.save
		flash[:notice] = "Count Master Updated Successfully!"
        redirect_to(:action => 'view')
      else
         flash[:notice] = "*** LAST COUNT NOT PROCESSED ***" 
        render('view')
      end
  end

private
def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'admin',
                                             :sub_module => 'invcount',
                                             :access_page => 'master').first
      unless found_page_access
         flash[:notice] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems_login', :action => 'index.html')
      return false
      else return true
      end
 end

end
