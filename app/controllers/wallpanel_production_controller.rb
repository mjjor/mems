class WallpanelProductionController < ApplicationController
    
	layout "mems"  

	before_action :confirm_logged_in
    before_action :confirm_page_access

  def index
     #   @dayfootage = ActiveRecord::Base.connection.select_value("SELECT wpFtDay(CURRENT_DATE)")
     #   @dayfootage = @dayfootage.to_f
        # @dayfootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
        
     #   @vrsDayFootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
     #   @opaDayFootage = Wallpanels.where("(`wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
         
     #   @sthDaySqFt = ActiveRecord::Base.connection.select_value("SELECT sthSqFtDay(CURRENT_DATE)")
     #   @sthDaySqFt = @sthdaysqft.to_f

        # @wpadayfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").sum(:wpa_linear_footage).to_f.round(2)
        # @opadayfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").sum(:opa_linear_footage).to_f.round(2)
        # @dayfootage = (@wpadayfootage + @opadayfootage)

     #   @daypoundage = ActiveRecord::Base.connection.select_value("SELECT wpLbsDay(CURRENT_DATE)")
     #   @daypoundage = @daypoundage.to_f 
        # @daypoundage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        
        # @wpadaypoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").sum(:wpa_panel_weight).to_f.round(2)
        # @opadaypoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").sum(:opa_panel_weight).to_f.round(2)
        # @daypoundage = (@wpadaypoundage + @opadaypoundage)

     #   @daysqfootage = ActiveRecord::Base.connection.select_value("SELECT wpSqftDay(CURRENT_DATE)")
     #   @daysqfootage = @daysqfootage.to_f
        # @daysqfootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = DATE(CURRENT_DATE())").sum(:areagross).to_f.round(2)
        
        # @wpadaysqfootage= WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").sum(:wpa_panel_sqft).to_f.round(2)
        # @opadaysqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").sum(:opa_panel_sqft).to_f.round(2)
        # @daysqfootage = (@wpadaysqfootage + @opadaysqfootage)

     #   @daypanelcount = ActiveRecord::Base.connection.select_value("SELECT wpCntDay(CURRENT_DATE)")
     #   @daypanelcount = @daypanelcount.to_f
        # @daypanelcount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(updated_at) = CURDATE() AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')"]).count("DATE(`updated_at`)")
     #   @vrsDayPanelCount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(updated_at) = CURDATE() AND (`wallpanel_trackings`.`trans_code` = 'VRS')"]).count("DATE(`updated_at`)")
     #   @opaDayPanelCount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(updated_at) = CURDATE() AND (`wallpanel_trackings`.`trans_code` = 'OPA')"]).count("DATE(`updated_at`)")
        # @wpadaypanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").select("wpa_count")
        # @opadaypanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").select("opa_count")
        # @daypanelcount = (@wpadaypanelcount + @opadaypanelcount)
    
        #@dayfoot0 = @dayfootage.first[0].to_f
        #@dayfoot1 = @dayfootage[1]
        #@dayfoot2 = @dayfootage[2]

     #   @sthDayPanelCount =  ActiveRecord::Base.connection.select_value("SELECT sthCntDay(CURRENT_DATE)")
     #   @sthDayPanelCount = @sthdaypanelcount.to_f

  #  if  @dayfootage > 0 then
  #      @dayavgpanelfootage = (Float(@dayfootage)/@daypanelcount).round(2)
  #  else @dayavgpanelfootage = 0
  #  end
    
  #  if  @dayfootage > 0 then
  #      @dayavgpanelsqfootage = (Float(@daysqfootage)/@daypanelcount).round(2)
  #  else @dayavgpanelsqfootage = 0
  #  end
    
  #  if  @dayfootage > 0 then    
  #      @dayavgpanelpoundage = (Float(@daypoundage)/@daypanelcount).round(2)
  #  else @dayavgpanelpoundage = 0
  #  end

        #@prevdayfootage = ActiveRecord::Base.connection.select_value("SELECT wpFtPrevDay(CURRENT_DATE)")
        #@prevdayfootage = @prevdayfootage.to_f
        
        # @prevdayfootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = (SELECT DATE(`wpt`.`updated_at`) FROM `wallpanel_trackings` wpt WHERE DATE(`wpt`.`updated_at`) < CURDATE() ORDER BY `wpt`.`updated_at` DESC LIMIT 1)").sum(:length).to_f.round(2)
         
        #@wpaprevdayfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:wpa_linear_footage).first.to_f
        #@opaprevdayfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:opa_linear_footage).first.to_f
        #@prevdayfootage = (@wpaprevdayfootage + @opaprevdayfootage)

  #      @wpaprevdayfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:wpa_linear_footage).first.to_f.round(2)
  #      @opaprevdayfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:opa_linear_footage).first.to_f.round(2)
  #      @prevdayfootage = (@wpaprevdayfootage + @opaprevdayfootage)

        #@prevdaypoundage = ActiveRecord::Base.connection.select_value("SELECT wpLbsPrevDay(CURRENT_DATE)")
        #@prevdaypoundage = @prevdaypoundage.to_f
        # @prevdaypoundage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND  DATE(`wallpanel_trackings`.`updated_at`) = (SELECT DATE(`wpt`.`updated_at`) FROM `wallpanel_trackings` wpt WHERE DATE(`wpt`.`updated_at`) < CURDATE() ORDER BY `wpt`.`updated_at` DESC LIMIT 1)").sum(:weight).to_f.round(2)
        
  #      @wpaprevdaypoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:wpa_panel_weight).first.to_f.round(2)
  #      @opaprevdaypoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:opa_panel_weight).first.to_f.round(2)
  #      @prevdaypoundage = (@wpaprevdaypoundage + @opaprevdaypoundage)         

        #@prevdaysqfootage = ActiveRecord::Base.connection.select_value("SELECT wpSqftPrevDay(CURRENT_DATE)")
        #@prevdaysqfootage = @prevdaysqfootage.to_f
        # @prevdaysqfootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND  DATE(`wallpanel_trackings`.`updated_at`) = (SELECT DATE(`wpt`.`updated_at`) FROM `wallpanel_trackings` wpt WHERE DATE(`wpt`.`updated_at`) < CURDATE() ORDER BY `wpt`.`updated_at` DESC LIMIT 1)").sum(:areagross).to_f.round(2)

  #      @wpaprevdaysqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:wpa_panel_sqft).first.to_f.round(2)
  #      @opaprevdaysqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:opa_panel_sqft).first.to_f.round(2)
  #      @prevdaysqfootage = (@wpaprevdaysqfootage + @opaprevdaysqfootage)

        #@prevdaypanelcount = ActiveRecord::Base.connection.select_value("SELECT wpCntPrevDay(CURRENT_DATE)")
        #@prevdaypanelcount = @prevdaypanelcount.to_i
        # @prevdaypanelcount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) = (SELECT DATE(`wpt`.`updated_at`) FROM `wallpanel_trackings` wpt WHERE DATE(`wpt`.`updated_at`) < CURDATE() AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA') ORDER BY `wpt`.`updated_at` DESC LIMIT 1)"]).count("DATE(`updated_at`)")
        
  #      @wpaprevdaypanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:wpa_count).first.to_f.round(2)
  #      @opaprevdaypanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:opa_count).first.to_f.round(2)
  #      @prevdaypanelcount = (@wpaprevdaypanelcount + @opaprevdaypanelcount)

  #      @prevdayavgfootage = (Float(@prevdayfootage)/@prevdaypanelcount).round(2)
  #      @prevdayavgpanelpoundage = (Float(@prevdaypoundage)/@prevdaypanelcount).round(2)
  #      @prevdayavgpanelsqfootage = (Float(@prevdaysqfootage)/@prevdaypanelcount).round(2)
        
        # @wtdfootage = ActiveRecord::Base.connection.select_value("SELECT wpFt7Day(CURRENT_DATE)")
        # @wtdfootage = @mtdfootage.to_f
        # @wtdfootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
        
  #      @wpawtdfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_linear_footage).to_f.round(2)
  #      @opawtdfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_linear_footage).to_f.round(2)
  #      @wtdfootage = (@wpawtdfootage + @opawtdfootage)

        # @wtdpoundage = ActiveRecord::Base.connection.select_value("SELECT wpLbs7Day(CURRENT_DATE)")
        # @wtdpoundage = @wtdpoundage.to_f
        # @wtdpoundage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        
  #      @wpawtdpoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_panel_weight).to_f.round(2)
  #      @opawtdpoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_panel_weight).to_f.round(2)
  #      @wtdpoundage = (@wpawtdpoundage + @opawtdpoundage)

        # @wtdsqfootage = ActiveRecord::Base.connection.select_value("SELECT wpSqft7Day(CURRENT_DATE)")
        # @wtdsqfootage = @wtdsqfootage.to_f
        #@wtdsqfootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:areagross).to_f.round(2)
        
  #      @wpawtdsqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_panel_sqft).to_f.round(2)
  #      @opawtdsqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_panel_sqft).to_f.round(2)
  #      @wtdsqfootage = (@wpawtdsqfootage + @opawtdsqfootage)

        #@wtdpanelcount = ActiveRecord::Base.connection.select_value("SELECT wpCnt7Day(CURRENT_DATE)")
        #@wtdpanelcount = @wtdpanelcount.to_i
        # @wtdpanelcount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND DATE(updated_at) < CURDATE() AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')"]).count("DATE(`updated_at`)")
        
  #      @wpawtdpanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_count).to_i
  #      @opawtdpanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_count).to_i
  #      @wtdpanelcount = (@wpawtdpanelcount + @opawtdpanelcount)

        # @wtddays = ActiveRecord::Base.connection.select_value("SELECT wpWkDayCnt(CURRENT_DATE)")
        # @wtddays = @wtddays.to_i
        # @wtddays = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= ? AND DATE(`updated_at`) < ? AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')", Date.today-7.days, Date.today]).distinct.count("DATE(`updated_at`)")
        
  #      @wtddays = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).distinct.count("DATE(`proddate`)").to_i    

  #      @avgwtdfootage = (Float(@wtdfootage)/@wtddays).round(2)
  #      @avgwtdpoundage = (Float(@wtdpoundage)/@wtddays).round(2)
  #      @avgwtdsqfootage = (Float(@wtdsqfootage)/@wtddays).round(2)
  #      @avgwtdpanelcount = (Float(@wtdpanelcount)/@wtddays).round(2)
  #      @avgwtdpanelfootage = (Float(@wtdfootage)/@wtdpanelcount).round(2)
  #      @avgwtdpanelpoundage = (Float(@wtdpoundage)/@wtdpanelcount).round(2)
  #      @avgwtdpanelsqfootage = (Float(@wtdsqfootage)/@wtdpanelcount).round(2)
        
        # @mtdfootage = ActiveRecord::Base.connection.select_value("SELECT wpFt30Day(CURRENT_DATE)")
        # @mtdfootage = @mtdfootage.to_f
        # @mtdfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
        
  #      @wpamtdfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_linear_footage).to_f.round(2)
  #     @opamtdfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_linear_footage).to_f.round(2)
  #      @mtdfootage = (@wpamtdfootage + @opamtdfootage)

        #@mtdpoundage = ActiveRecord::Base.connection.select_value("SELECT wpLbs30Day(CURRENT_DATE)")
        #@mtdpoundage = @mtdpoundage.to_f
        # @mtdpoundage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        
  #      @wpamtdpoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_panel_weight).to_f.round(2)
  #      @opamtdpoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_panel_weight).to_f.round(2)
  #      @mtdpoundage = (@wpamtdpoundage + @opamtdpoundage)

        #@mtdsqfootage = ActiveRecord::Base.connection.select_value("SELECT wpSqft30Day(CURRENT_DATE)")
        #@mtdsqfootage = @mtdsqfootage.to_f
        # @mtdsqfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:areagross).to_f.round(2)
        
  #      @wpamtdsqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_panel_sqft).to_f.round(2)
  #      @opamtdsqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_panel_sqft).to_f.round(2)
  #      @mtdsqfootage = (@wpamtdsqfootage + @opamtdsqfootage) 

        #@mtdpanelcount = ActiveRecord::Base.connection.select_value("SELECT wpCnt30Day(CURRENT_DATE)")
        #@mtdpanelcount = @mtdpanelcount .to_i
        # @mtdpanelcount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND DATE(updated_at) < CURDATE() AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')"]).count("DATE(`updated_at`)")
        
  #      @wpamtdpanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_count).to_i
  #      @opamtdpanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_count).to_i
  #      @mtdpanelcount = (@wpamtdpanelcount + @opamtdpanelcount) 

        # @mtddays = ActiveRecord::Base.connection.select_value("SELECT wpMthDayCnt(CURRENT_DATE)")
        # @mtddays = @mtddays.to_i
        # @mtddays = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= ? AND DATE(updated_at) < ? AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')", Date.today-30.days, Date.today]).distinct.count("DATE(`updated_at`)")
         
  #      @mtddays = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).distinct.count("DATE(`proddate`)").to_i 

  #      @avgmtdfootage = (Float(@mtdfootage)/@mtddays).round(2)
  #      @avgmtdpoundage = (Float(@mtdpoundage)/@mtddays).round(2)
  #      @avgmtdsqfootage = (Float(@mtdsqfootage)/@mtddays).round(2)
  #      @avgmtdpanelcount = (Float(@mtdpanelcount)/@mtddays).round(2)
  #      @avgmtdpanelfootage = (Float(@mtdfootage)/@mtdpanelcount).round(2)
  #      @avgmtdpanelpoundage =  (Float(@mtdpoundage)/@mtdpanelcount).round(2)
  #      @avgmtdpanelsqfootage = (Float(@mtdsqfootage)/@mtdpanelcount).round(2)

        @exportKeys = Wallpanels.select(:exportkey).distinct
  end

 def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'production',
                                            :sub_module => 'wall_panel').first
      unless found_page_access
         flash[:alert] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems', :action => 'login')
      return false
      else return true
      end
  end

end