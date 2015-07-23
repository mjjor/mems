class WallpanelTrackingController < ApplicationController
	
    layout "mems"

    before_action :confirm_logged_in
    before_action :confirm_page_access

	def new
      @panel = WallpanelTracking.new
      @trans_code = params[:trans_code]
      @dayfootage = ActiveRecord::Base.connection.select_value("SELECT wpFtDay(CURRENT_DATE)")
      @dayfootage = @dayfootage.to_f
      @vrsDayFootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
      @opaDayFootage = Wallpanels.where("(`wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
      @sthDaySqFt = ActiveRecord::Base.connection.select_value("SELECT sthSqFtDay(CURRENT_DATE)")
      @sthDaySqFt = @sthdaysqft.to_f
      @vrsDayPanelCount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(updated_at) = CURDATE() AND (`wallpanel_trackings`.`trans_code` = 'VRS')"]).count("DATE(`updated_at`)")
      @opaDayPanelCount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(updated_at) = CURDATE() AND (`wallpanel_trackings`.`trans_code` = 'OPA')"]).count("DATE(`updated_at`)")
      @sthDayPanelCount =  ActiveRecord::Base.connection.select_value("SELECT sthCntDay(CURRENT_DATE)")
      @sthDayPanelCount = @sthdaypanelcount.to_f
	end

	def create
     @panel = WallpanelTracking.where(panellabel: panel_params[:panellabel], trans_code: panel_params[:trans_code]).first_or_initialize
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
         flash[:notice] = "Panel successfully processed!"
         redirect_to(:action => 'new', :trans_code => @panel.trans_code)
      else
         flash[:alert] = "Last panel scanned not processed"
        @trans_code = @panel.trans_code 
        render('new')
      end
	end

  def show
    case params[:scanned]
      when 'scanned' then
        @scannedtoday = Wallpanels.where("(wallpanels.status != 'open' AND wallpanels.status != ' ') AND `wallpanel_trackings`.`trans_code` = ?", params[:transcode]).joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(wallpanel_trackings.updated_at) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) ").lastupdate
      when 'notscanned' then
        if params[:transcode] == 'STH' 
          @scannedtoday = Wallpanels.where(:status => 'open', :is_sheathed => true).oldestupdate
        else
          @scannedtoday = Wallpanels.where(:status => 'open').oldestupdate
        end 
    end
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

  def send_sth_notification
    if Rails.env.development?
    MemsMailer.versa_down('mjordan@magest.com', 'STH').deliver
    end 
    if Rails.env.production?
    MemsMailer.versa_down('gmoore@magest.com,rkirk@magest.com', 'STH').deliver
    end
    flash[:notice] = "Request Sent!"
    redirect_to(:action => 'new', :trans_code => 'STH')
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
         flash[:alert] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems', :action => 'login')
      return false
      else return true
      end
  end
end
