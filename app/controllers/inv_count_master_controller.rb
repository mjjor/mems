class InvCountMasterController < ApplicationController

layout 'mems'

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
end
