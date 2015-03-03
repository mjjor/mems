class WallpanelTrackingController < ApplicationController
	
    before_action :confirm_logged_in
    before_action :confirm_page_access

    layout "mems"

	def new
     @panel = WallpanelTracking.new
     @trans_code = params[:trans_code]
     #@daysfootage   = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DAYOFMONTH(`wallpanel_trackings`.`updated_at`) = DAYOFMONTH(CURRENT_DATE() -1)  AND MONTH(`wallpanel_trackings`.`updated_at`) = MONTH(CURRENT_DATE())").sum(:length)
     #@weeksfootage  = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DAYOFMONTH(`wallpanel_trackings`.`updated_at`) = DAYOFMONTH(CURRENT_DATE() -7)  AND MONTH(`wallpanel_trackings`.`updated_at`) = MONTH(CURRENT_DATE())").sum(:length)
     #@monthsfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND MONTH(`wallpanel_trackings`.`updated_at`) = MONTH(CURRENT_DATE())").sum(:length)
  
	end

	def create
    # @panelid = Wallpanels.where(panellabel: params[:panellabel]).pluck(:id) 
     @panel = WallpanelTracking.where(panellabel: panel_params[:panellabel]).first_or_initialize
     #@panel = WallpanelTracking.new 
     @wpid = Wallpanels.where(panellabel: panel_params[:panellabel]).limit(1).pluck(:id)
	   @panel.wallpanels_id = @wpid[:id[0].to_i]
     @panel.panellabel = panel_params[:panellabel]
     @panel.trans_code = panel_params[:trans_code]
     @panel.users_id   = session[:user_id]
     @panel.save
      if @panel.save
         updpanel = Wallpanels.find(@wpid[0].to_i)
         updpanel.status = @panel.trans_code
         @trans_code = @panel.trans_code
         updpanel.save
         @panel.touch
         flash[:notice] = "Panel record created successfully!"
         redirect_to(:action => 'new', :trans_code => @panel.trans_code)
      else
         flash[:notice] = "PANEL NOT PROCESSED"
        render('new', :trans_code => @panel.trans_code)
      end
	end

  def show
     @scannedtoday = Wallpanels.where("(wallpanels.status != 'open' AND wallpanels.status != ' ')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(wallpanel_trackings.updated_at) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)").lastupdate
  end

  def send_vrs_notification
    if Rails.env.development?
    MemsMailer.versa_down('mjordan@magest.com', 'VRS').deliver
    end 
    if Rails.env.production?
    MemsMailer.versa_down('mjordan@magest.com,gmoore@magest.com,rkirk@magest.com', 'VRS').deliver
    end  
    flash[:notice] = "Request Sent!"
    redirect_to(:action => 'new', :trans_code => 'VRS')
  end

  def send_opa_notification
    if Rails.env.development?
    MemsMailer.versa_down('mjordan@magest.com', 'OPA').deliver
    end 
    if Rails.env.production?
    MemsMailer.versa_down('gmoore@magest.com,rkirk@magest.com', 'OPA').deliver
    end
    flash[:notice] = "Request Sent!"
    redirect_to(:action => 'new', :trans_code => 'OPA')
  end  
   
def send_ncn_notification
    if Rails.env.development?
    MemsMailer.versa_down('mjordan@magest.com', 'NCN').deliver
    end 
    if Rails.env.production?
    MemsMailer.versa_down('gmoore@magest.com,rkirk@magest.com', 'NCN').deliver
    end
    flash[:notice] = "Request Sent!"
    redirect_to(:controller => 'truss_roll_forming',:action => 'index', :trans_code => 'NCN', :workstation => 3)
  end

def send_rlf_notification
    if Rails.env.development?
    MemsMailer.versa_down('mjordan@magest.com', 'RLF').deliver
    end 
    if Rails.env.production?
    MemsMailer.versa_down('gmoore@magest.com,rkirk@magest.com', 'RLF').deliver
    end
    flash[:notice] = "Request Sent!"
    redirect_to(:controller => 'rollformer_qa_check', :action => 'index' , :trans_code => 'RLF', :workstation => 1)
  end

private

def panel_params
    params.require(:wallpanel_tracking).permit(:panellabel, :trans_code, :users_id, :wallpanels_id)
end

def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'production',
                                             :sub_module => 'wall_panel',
                                             :access_page => 'panel_scan').first
      unless found_page_access
         flash[:notice] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems_login', :action => 'index.html')
      return false
      else return true
      end
  end
end
