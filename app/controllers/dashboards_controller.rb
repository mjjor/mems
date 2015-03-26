class DashboardsController < ApplicationController
  
  layout "mems"

  before_action :confirm_logged_in
  
  before_action :confirm_page_access

  def index
    @dayfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
        @daypoundage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        @daysqfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = DATE(CURRENT_DATE())").sum(:areagross).to_f.round(2)
        @daypanelcount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(updated_at) = CURDATE()"]).count("DATE(`updated_at`)")
    
    if  @dayfootage > 0 then
        @dayavgpanelfootage = (Float(@dayfootage)/@daypanelcount).round(2)
    else @dayavgpanelfootage = 0
    end
    
    if  @dayfootage > 0 then
        @dayavgpanelsqfootage = (Float(@daysqfootage)/@daypanelcount).round(2)
    else @dayavgpanelsqfootage = 0
    end
    
    if  @dayfootage > 0 then    
        @dayavgpanelpoundage = (Float(@daypoundage)/@daypanelcount).round(2)
    else @dayavgpanelpoundage = 0
    end

        @prevdayfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = (SELECT DATE(`wpt`.`updated_at`) FROM `wallpanel_trackings` wpt WHERE DATE(`wpt`.`updated_at`) < CURDATE() ORDER BY `wpt`.`updated_at` DESC LIMIT 1)").sum(:length).to_f.round(2)
        @prevdaypoundage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND  DATE(`wallpanel_trackings`.`updated_at`) = (SELECT DATE(`wpt`.`updated_at`) FROM `wallpanel_trackings` wpt WHERE DATE(`wpt`.`updated_at`) < CURDATE() ORDER BY `wpt`.`updated_at` DESC LIMIT 1)").sum(:weight).to_f.round(2)
        @prevdaysqfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND  DATE(`wallpanel_trackings`.`updated_at`) = (SELECT DATE(`wpt`.`updated_at`) FROM `wallpanel_trackings` wpt WHERE DATE(`wpt`.`updated_at`) < CURDATE() ORDER BY `wpt`.`updated_at` DESC LIMIT 1)").sum(:areagross).to_f.round(2)
        @prevdaypanelcount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) = (SELECT DATE(`wpt`.`updated_at`) FROM `wallpanel_trackings` wpt WHERE DATE(`wpt`.`updated_at`) < CURDATE() ORDER BY `wpt`.`updated_at` DESC LIMIT 1)"]).count("DATE(`updated_at`)")
        @prevdayavgfootage = (Float(@prevdayfootage)/@prevdaypanelcount).round(2)
        @prevdayavgpanelpoundage = (Float(@prevdaypoundage)/@prevdaypanelcount).round(2)
        @prevdayavgpanelsqfootage = (Float(@prevdaysqfootage)/@prevdaypanelcount).round(2)
        
        
        @wtdfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
        @wtdpoundage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        @wtdsqfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:areagross).to_f.round(2)
        @wtdpanelcount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND DATE(updated_at) < CURDATE()"]).count("DATE(`updated_at`)")
        
        @wtddays = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND DATE(updated_at) < CURDATE()"]).distinct.count("DATE(`updated_at`)")
    
        @avgwtdfootage = (Float(@wtdfootage)/@wtddays).round(2)
        @avgwtdpoundage = (Float(@wtdpoundage)/@wtddays).round(2)
        @avgwtdsqfootage = (Float(@wtdsqfootage)/@wtddays).round(2)
        @avgwtdpanelcount = (Float(@wtdpanelcount)/@wtddays).round(2)
        @avgwtdpanelfootage = (Float(@wtdfootage)/@wtdpanelcount).round(2)
        @avgwtdpanelpoundage = (Float(@wtdpoundage)/@wtdpanelcount).round(2)
        @avgwtdpanelsqfootage = (Float(@wtdsqfootage)/@wtdpanelcount).round(2)
        
        @mtdfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
        @mtdpoundage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        @mtdsqfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:areagross).to_f.round(2)
        @mtdpanelcount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND DATE(updated_at) < CURDATE()"]).count("DATE(`updated_at`)")

        @mtddays = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND DATE(updated_at) < CURDATE()"]).distinct.count("DATE(`updated_at`)")
    
        @avgmtdfootage = (Float(@mtdfootage)/@mtddays).round(2)
        @avgmtdpoundage = (Float(@mtdpoundage)/@mtddays).round(2)
        @avgmtdsqfootage = (Float(@mtdsqfootage)/@mtddays).round(2)
        @avgtmdpanelcount = (Float(@mtdpanelcount)/@mtddays).round(2)
        @avgmtdpanelfootage = (Float(@mtdfootage)/@mtdpanelcount).round(2)
        @avgmtdpanelpoundage =  (Float(@mtdpoundage)/@mtdpanelcount).round(2)
        @avgmtdpanelsqfootage = (Float(@mtdsqfootage)/@mtdpanelcount).round(2)

         @exportKeys = Wallpanels.select(:exportkey).distinct 
  end

  def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'dashboards',
                                             :sub_module => 'wall_panel_dash').first
      unless found_page_access
         flash[:notice] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems_login', :action => 'index.html')
      return false
      else return true
      end
  end

end
