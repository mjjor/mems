class DashboardsController < ApplicationController
  
  layout "mems"

  before_action :confirm_logged_in
  
  before_action :confirm_page_access

  def index

# ######################  Wallpanel Functions ################# #

        @dayfootage = ActiveRecord::Base.connection.select_value("SELECT wpFtDay(CURRENT_DATE)")
        @dayfootage = @dayfootage.to_f

        @sthdaysqft = ActiveRecord::Base.connection.select_value("SELECT sthSqFtDay(CURRENT_DATE)")
        @sthdaysqft = @sthdaysqft.to_f
        
        # @wpadayfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").sum(:wpa_linear_footage).to_f.round(2)
        # @opadayfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").sum(:opa_linear_footage).to_f.round(2)
        # @dayfootage = (@wpadayfootage + @opadayfootage)
        #@dayfootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
        
        @daypoundage = ActiveRecord::Base.connection.select_value("SELECT wpLbsDay(CURRENT_DATE)")
        @daypoundage = @daypoundage.to_f 
        
        # @wpadaypoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").sum(:wpa_panel_weight).to_f.round(2)
        # @opadaypoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").sum(:opa_panel_weight).to_f.round(2)
        # @daypoundage = (@wpadaypoundage + @opadaypoundage)
        # @daypoundage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        
         @daysqfootage = ActiveRecord::Base.connection.select_value("SELECT wpSqftDay(CURRENT_DATE)")
         @daysqfootage = @daysqfootage.to_f
        # @daysqfootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = DATE(CURRENT_DATE())").sum(:areagross).to_f.round(2)
        
        # @wpadaysqfootage= WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").sum(:wpa_panel_sqft).to_f.round(2)
        # @opadaysqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").sum(:opa_panel_sqft).to_f.round(2)
        # @daysqfootage = (@wpadaysqfootage + @opadaysqfootage)
        
         @daypanelcount = ActiveRecord::Base.connection.select_value("SELECT wpCntDay(CURRENT_DATE)")
         @daypanelcount = @daypanelcount.to_f
        # @daypanelcount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(updated_at) = CURDATE() AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')"]).count("DATE(`updated_at`)")
        
        # @wpadaypanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").select("wpa_count")
        # @opadaypanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) = DATE(CURRENT_DATE())").select("opa_count")
        # @daypanelcount = (@wpadaypanelcount + @opadaypanelcount)
            
        @sthdaypanelcount =  ActiveRecord::Base.connection.select_value("SELECT sthCntDay(CURRENT_DATE)")
        @sthdaypanelcount = @sthdaypanelcount.to_f

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

        # @prevdayfootage = ActiveRecord::Base.connection.select_value("SELECT wpFtPrevDay(CURRENT_DATE)")
        # @prevdayfootage = @prevdayfootage.to_f
        # @prevdayfootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) = (SELECT DATE(`wpt`.`updated_at`) FROM `wallpanel_trackings` wpt WHERE DATE(`wpt`.`updated_at`) < CURDATE() ORDER BY `wpt`.`updated_at` DESC LIMIT 1)").sum(:length).to_f.round(2)
         
        @wpaprevdayfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:wpa_linear_footage).first.to_f.round(2)
        @opaprevdayfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:opa_linear_footage).first.to_f.round(2)
        @prevdayfootage = (@wpaprevdayfootage + @opaprevdayfootage)

        #@prevdaypoundage = ActiveRecord::Base.connection.select_value("SELECT wpLbsPrevDay(CURRENT_DATE)")
        #@prevdaypoundage = @prevdaypoundage.to_f
        # @prevdaypoundage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND  DATE(`wallpanel_trackings`.`updated_at`) = (SELECT DATE(`wpt`.`updated_at`) FROM `wallpanel_trackings` wpt WHERE DATE(`wpt`.`updated_at`) < CURDATE() ORDER BY `wpt`.`updated_at` DESC LIMIT 1)").sum(:weight).to_f.round(2)
            
        @wpaprevdaypoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:wpa_panel_weight).first.to_f.round(2)
        @opaprevdaypoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:opa_panel_weight).first.to_f.round(2)
        @prevdaypoundage = (@wpaprevdaypoundage + @opaprevdaypoundage)        

        #@prevdaysqfootage = ActiveRecord::Base.connection.select_value("SELECT wpSqftPrevDay(CURRENT_DATE)")
        #@prevdaysqfootage = @prevdaysqfootage.to_f
        # @prevdaysqfootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND  DATE(`wallpanel_trackings`.`updated_at`) = (SELECT DATE(`wpt`.`updated_at`) FROM `wallpanel_trackings` wpt WHERE DATE(`wpt`.`updated_at`) < CURDATE() ORDER BY `wpt`.`updated_at` DESC LIMIT 1)").sum(:areagross).to_f.round(2)
                
        @wpaprevdaysqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:wpa_panel_sqft).first.to_f.round(2)
        @opaprevdaysqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:opa_panel_sqft).first.to_f.round(2)
        @prevdaysqfootage = (@wpaprevdaysqfootage + @opaprevdaysqfootage)


        #@prevdaypanelcount = ActiveRecord::Base.connection.select_value("SELECT wpCntPrevDay(CURRENT_DATE)")
        #@prevdaypanelcount = @prevdaypanelcount.to_i
        # @prevdaypanelcount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) = (SELECT DATE(`wpt`.`updated_at`) FROM `wallpanel_trackings` wpt WHERE DATE(`wpt`.`updated_at`) < CURDATE() AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA') ORDER BY `wpt`.`updated_at` DESC LIMIT 1)"]).count("DATE(`updated_at`)")
 
        @wpaprevdaypanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:wpa_count).first.to_f.round(2)
        @opaprevdaypanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) < CURDATE()").order(proddate: :desc).pluck(:opa_count).first.to_f.round(2)
        @prevdaypanelcount = (@wpaprevdaypanelcount + @opaprevdaypanelcount)        

        if @prevdayfootage > 0 then
            @prevdayavgfootage = (Float(@prevdayfootage)/@prevdaypanelcount).round(2)
        else @prevdayavgfootage = 0
        end

        if @prevdaypoundage > 0 then
        @prevdayavgpanelpoundage = (Float(@prevdaypoundage)/@prevdaypanelcount).round(2)
        else @prevdayavgpanelpoundage = 0
        end

        if @prevdaysqfootage > 0 then
            @prevdayavgpanelsqfootage = (Float(@prevdaysqfootage)/@prevdaypanelcount).round(2)
        else @prevdayavgpanelsqfootage = 0
        end
        
        #@wtdfootage = ActiveRecord::Base.connection.select_value("SELECT wpFt7Day(CURRENT_DATE)")
        #@wtdfootage = @wtdfootage.to_f
        # @wtdfootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
        
        @wpawtdfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_linear_footage).to_f.round(2)
        @opawtdfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_linear_footage).to_f.round(2)
        @wtdfootage = (@wpawtdfootage + @opawtdfootage)

        #@wtdpoundage = ActiveRecord::Base.connection.select_value("SELECT wpLbs7Day(CURRENT_DATE)")
        #@wtdpoundage = @wtdpoundage.to_f
        # @wtdpoundage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        
        @wpawtdpoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_panel_weight).to_f.round(2)
        @opawtdpoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_panel_weight).to_f.round(2)
        @wtdpoundage = (@wpawtdpoundage + @opawtdpoundage)

        @wtdsqfootage = ActiveRecord::Base.connection.select_value("SELECT wpSqft7Day(CURRENT_DATE)")
        @wtdsqfootage = @wtdsqfootage.to_f
        #@wtdsqfootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:areagross).to_f.round(2)

        @wpawtdsqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_panel_sqft).to_f.round(2)
        @opawtdsqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_panel_sqft).to_f.round(2)
        @wtdsqfootage = (@wpawtdsqfootage + @opawtdsqfootage)        

        #@wtdpanelcount = ActiveRecord::Base.connection.select_value("SELECT wpCnt7Day(CURRENT_DATE)")
        #@wtdpanelcount = @wtdpanelcount.to_i
        # @wtdpanelcount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND DATE(updated_at) < CURDATE() AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')"]).count("DATE(`updated_at`)")
        
        @wpawtdpanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_count).to_i
        @opawtdpanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_count).to_i
        @wtdpanelcount = (@wpawtdpanelcount + @opawtdpanelcount)

        @wpawtdmaterialfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_material_linear_footage).to_f.round(2)
        @opawtdmaterialfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_material_linear_footage).to_f.round(2)
        @wtdmaterialfootage = (@wpawtdmaterialfootage + @opawtdmaterialfootage)

        #@wtddays = ActiveRecord::Base.connection.select_value("SELECT wpWkDayCnt(CURRENT_DATE)")
        #@wtddays = @wtddays.to_i
        # @wtddays = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= ? AND DATE(`updated_at`) < ? AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')", Date.today-7.days, Date.today]).distinct.count("DATE(`updated_at`)")
          
        @wtddays = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND (`wpa_production_summaries`.`wpa_count` != 0 OR `wpa_production_summaries`.`opa_count` != 0)").order(proddate: :desc).distinct.count("DATE(`proddate`)").to_i
        @wpawtddays = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND `wpa_production_summaries`.`wpa_count` != 0").order(proddate: :desc).distinct.count("DATE(`proddate`)").to_i
        @opawtddays = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND `wpa_production_summaries`.`opa_count` != 0").order(proddate: :desc).distinct.count("DATE(`proddate`)").to_i

        if @wtdfootage > 0 then
            @avgwtdfootage = (Float(@wtdfootage)/@wtddays).round(2)
        else @avgwtdfootage = 0
        end

        if @wpawtdfootage > 0 then
            @wpaavgwtdfootage = (Float(@wpawtdfootage)/@wpawtddays).round(2)
        else @wpaavgwtdfootage = 0
        end
        
        if @opawtdfootage > 0 then
            @opaavgwtdfootage = (Float(@opawtdfootage)/@opawtddays).round(2)
        else @opaavgwtdfootage = 0
        end

        if @wtdpoundage > 0 then
            @avgwtdpoundage = (Float(@wtdpoundage)/@wtddays).round(2)
        else @avgwtdpoundage = 0
        end
        
        if @wpawtdpoundage > 0 then
            @wpaavgwtdpoundage = (Float(@wpawtdpoundage)/@wpawtddays).round(2)
        else @wpaavgwtdpoundage = 0
        end
        
        if @opawtdpoundage > 0 then
            @opaavgwtdpoundage = (Float(@opawtdpoundage)/@opawtddays).round(2)
        else @opaavgwtdpoundage = 0
        end

        if @wtdsqfootage > 0 then
            @avgwtdsqfootage = (Float(@wtdsqfootage)/@wtddays).round(2)
        else @avgwtdsqfootage = 0
        end

        if @wpawtdsqfootage > 0 then
            @wpaavgwtdsqfootage = (Float(@wpawtdsqfootage)/@wpawtddays).round(2)
        else @wpaavgwtdsqfootage = 0
        end

        if @opawtdsqfootage > 0 then
            @opaavgwtdsqfootage = (Float(@opawtdsqfootage)/@opawtddays).round(2)
        else @opaavgwtdsqfootage = 0
        end

        
        if @wtdpanelcount > 0 then
            @avgwtdpanelcount = (Float(@wtdpanelcount)/@wtddays).round(2)
        else @avgwtdpanelcount = 0
        end

        if @wpawtdpanelcount > 0 then
            @wpaavgwtdpanelcount = (Float(@wpawtdpanelcount)/@wpawtddays).round(2)
        else @wpaavgwtdpanelcount = 0
        end
        if @opawtdpanelcount > 0 then
            @opaavgwtdpanelcount = (Float(@opawtdpanelcount)/@opawtddays).round(2)
        else @opaavgwtdpanelcount = 0
        end
        

        if @wtdfootage > 0 then
            @avgwtdpanelfootage = (Float(@wtdfootage)/@wtdpanelcount).round(2)
        else avgwtdpanelfootage = 0
        end

        if @wpawtdfootage > 0 then
            @wpaavgwtdpanelfootage = (Float(@wpawtdfootage)/@wpawtdpanelcount).round(2)
        else @wpaavgwtdpanelfootage = 0
        end

        if @opawtdfootage > 0 then
            @opaavgwtdpanelfootage = (Float(@opawtdfootage)/@opawtdpanelcount).round(2)
        else @opaavgwtdpanelfootage = 0
        end
        
        if @wtdpoundage > 0 then
            @avgwtdpanelpoundage = (Float(@wtdpoundage)/@wtdpanelcount).round(2)
        else @avgwtdpanelpoundage = 0
        end

        if @wpawtdfootage > 0 then
            @wpaavgwtdpanelfootage = (Float(@wpawtdfootage)/@wpawtdpanelcount).round(2)
        else @wpaavgwtdpanelfootage = 0
        end

        if @opawtdfootage > 0 then
            @opaavgwtdpanelfootage = (Float(@opawtdfootage)/@opawtdpanelcount).round(2)
        else @opaavgwtdpanelfootage = 0
        end

        if @wtdsqfootage > 0 then
            @avgwtdpanelsqfootage = (Float(@wtdsqfootage)/@wtdpanelcount).round(2)
        else @avgwtdpanelsqfootage = 0
        end

        if @wpawtdsqfootage > 0 then
            @wpaavgwtdpanelsqfootage = (Float(@wpawtdsqfootage)/@wpawtdpanelcount).round(2)
        else @wpaavgwtdpanelsqfootage = 0
        end

        if @opawtdsqfootage > 0 then
            @opaavgwtdpanelsqfootage = (Float(@opawtdsqfootage)/@opawtdpanelcount).round(2)
        else @opaavgwtdpanelsqfootage = 0
        end


        if @wtdmaterialfootage > 0 then
            @avgwtdmaterialfootage = (Float(@wtdmaterialfootage)/@wtddays).round(2)
        else @avgwtdmaterialfootage = 0
        end

        if @wpawtdmaterialfootage > 0 then
            @wpaavgwtdmaterialfootage = (Float(@wpawtdmaterialfootage)/@wpawtddays).round(2)
        else @wpaavgwtdmaterialfootage = 0
        end

        if @opawtdmaterialfootage > 0 then
            @opaavgwtdmaterialfootage = (Float(@opawtdmaterialfootage)/@opawtddays).round(2)
        else @opaavgwtdmaterialfootage = 0
        end


        if @wtdmaterialfootage > 0 then
            @avgpanelwtdmaterialfootage = (Float(@wtdmaterialfootage)/@wtdpanelcount).round(2)
        else @avgpanelwtdmaterialfootage = 0
        end

        if @wpawtdmaterialfootage > 0 then
            @wpaavgpanelwtdmaterialfootage = (Float(@wpawtdmaterialfootage)/@wpawtdpanelcount).round(2)
        else @wpaavgpanelwtdmaterialfootage = 0
        end

        if @opawtdmaterialfootage> 0 then
            @opaavgpanelwtdmaterialfootage = (Float(@opawtdmaterialfootage)/@opawtdpanelcount).round(2)
        else @opaavgpanelwtdmaterialfootage = 0
        end

        #@mtdfootage = ActiveRecord::Base.connection.select_value("SELECT wpFt30Day(CURRENT_DATE)")
        #@mtdfootage = @mtdfootage.to_f
        # @mtdfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
        
        @wpamtdfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_linear_footage).to_f.round(2)
        @opamtdfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_linear_footage).to_f.round(2)
        @mtdfootage = (@wpamtdfootage + @opamtdfootage)


        #@mtdpoundage = ActiveRecord::Base.connection.select_value("SELECT wpLbs30Day(CURRENT_DATE)")
        #@mtdpoundage = @mtdpoundage.to_f
        # @mtdpoundage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        
        @wpamtdpoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_panel_weight).to_f.round(2)
        @opamtdpoundage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_panel_weight).to_f.round(2)
        @mtdpoundage = (@wpamtdpoundage + @opamtdpoundage)

        # @mtdsqfootage = ActiveRecord::Base.connection.select_value("SELECT wpSqft30Day(CURRENT_DATE)")
        # @mtdsqfootage = @mtdsqfootage.to_f
        # @mtdsqfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:areagross).to_f.round(2)
        
        @wpamtdsqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_panel_sqft).to_f.round(2)
        @opamtdsqfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_panel_sqft).to_f.round(2)
        @mtdsqfootage = (@wpamtdsqfootage + @opamtdsqfootage)              

        # @mtdpanelcount = ActiveRecord::Base.connection.select_value("SELECT wpCnt30Day(CURRENT_DATE)")
        # @mtdpanelcount = @mtdpanelcount .to_i
        # @mtdpanelcount = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND DATE(updated_at) < CURDATE() AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')"]).count("DATE(`updated_at`)")

        @wpamtdpanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_count).to_i
        @opamtdpanelcount = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_count).to_i
        @mtdpanelcount = (@wpamtdpanelcount + @opamtdpanelcount)        

        # @mtddays = ActiveRecord::Base.connection.select_value("SELECT wpMthDayCnt(CURRENT_DATE)")
        # @mtddays = @mtddays.to_i
        # @mtddays = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= ? AND DATE(updated_at) < ? AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')", Date.today-30.days, Date.today]).distinct.count("DATE(`updated_at`)")
        
        @wpamtdmaterialfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:wpa_material_linear_footage).to_f.round(2)
        @opamtdmaterialfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:opa_material_linear_footage).to_f.round(2)
        @mtdmaterialfootage = (@wpamtdmaterialfootage + @opamtdmaterialfootage)

        @mtddays = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND (`wpa_production_summaries`.`wpa_count` != 0 OR `wpa_production_summaries`.`opa_count` != 0)").order(proddate: :desc).distinct.count("DATE(`proddate`)").to_i
        @wpamtddays = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND `wpa_production_summaries`.`wpa_count` != 0").order(proddate: :desc).distinct.count("DATE(`proddate`)").to_i
        @opamtddays = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND `wpa_production_summaries`.`opa_count` != 0").order(proddate: :desc).distinct.count("DATE(`proddate`)").to_i

        if @mtdfootage > 0 then
            @avgmtdfootage = (Float(@mtdfootage)/@mtddays).round(2)
        else @avgmtdfootage = 0
        end

        if @wpamtdfootage > 0 then
            @wpaavgmtdfootage = (Float(@wpamtdfootage)/@wpamtddays).round(2)
        else @wpaavgmtdfootage = 0
        end

        if @opamtdfootage > 0 then
            @opaavgmtdfootage = (Float(@opamtdfootage)/@opamtddays).round(2)
        else @opaavgmtdfootage = 0
        end

        if @mtdpoundage > 0 then
            @avgmtdpoundage = (Float(@mtdpoundage)/@mtddays).round(2)
        else @avgmtdpoundage = 0
        end
        
        if @wpamtdpoundage > 0 then
            @wpaavgmtdpoundage = (Float(@wpamtdpoundage)/@wpamtddays).round(2)
        else @wpaavgmtdpoundage = 0
        end

        if @opamtdpoundage > 0 then
            @opaavgmtdpoundage = (Float(@opamtdpoundage)/@opamtddays).round(2)
        else @opaavgmtdpoundage = 0
        end
        
        if @mtdsqfootage > 0 then
            @avgmtdsqfootage = (Float(@mtdsqfootage)/@mtddays).round(2)
        else @avgmtdsqfootage = 0
        end
        
        if @wpamtdsqfootage > 0 then
            @wpaavgmtdsqfootage = (Float(@wpamtdsqfootage)/@wpamtddays).round(2)
        else @wpaavgmtdsqfootage = 0
        end

        if @opamtdsqfootage > 0 then
            @opaavgmtdsqfootage = (Float(@opamtdsqfootage)/@opamtddays).round(2)
        else @opaavgmtdsqfootage = 0
        end
        
        if @mtdpanelcount > 0 then
            @avgmtdpanelcount = (Float(@mtdpanelcount)/@mtddays).round(2)
        else @avgmtdpanelcount = 0
        end

        if @wpamtdpanelcount > 0 then
            @wpaavgmtdpanelcount = (Float(@wpamtdpanelcount)/@wpamtddays).round(2)
        else @wpaavgmtdpanelcount = 0
        end

        if @opamtdpanelcount = 0 then
            @opaavgmtdpanelcount = (Float(@opamtdpanelcount)/@opamtddays).round(2)
        else @opaavgmtdpanelcount = 0
        end
        
        if @mtdfootage > 0 then
        @avgmtdpanelfootage = (Float(@mtdfootage)/@mtdpanelcount).round(2)
        else @avgmtdpanelfootage = 0
        end

        if @wpamtdfootage > 0 then
            @wpaavgmtdpanelfootage = (Float(@wpamtdfootage)/@wpamtdpanelcount).round(2)
        else @wpaavgmtdpanelfootage = 0
        end

        if @opamtdfootage > 0 then
            @opaavgmtdpanelfootage = (Float(@opamtdfootage)/@opamtdpanelcount).round(2)
        else @opaavgmtdpanelfootage = 0
        end
        
        if @mtdpoundage > 0 then
            @avgmtdpanelpoundage = (Float(@mtdpoundage)/@mtdpanelcount).round(2)
        else @avgmtdpanelpoundage = 0
        end
        @wpaavgmtdpanelpoundage =  (Float(@wpamtdpoundage)/@wpamtdpanelcount).round(2)
        
        if @opamtdpoundage > 0 then
            @opaavgmtdpanelpoundage = (Float(@opamtdpoundage)/@opamtdpanelcount).round(2)
        else @opaavgmtdpanelpoundage = 0
        end
        
        if @mtdsqfootage > 0 then
            @avgmtdpanelsqfootage = (Float(@mtdsqfootage)/@mtdpanelcount).round(2)
        else @avgmtdpanelsqfootage = 0
        end

        if @wpamtdsqfootage > 0 then
            @wpaavgmtdpanelsqfootage = (Float(@wpamtdsqfootage)/@wpamtdpanelcount).round(2)
        else @wpaavgmtdpanelsqfootage = 0
        end

        if @opamtdsqfootage > 0 then
            @opaavgmtdpanelsqfootage = (Float(@opamtdsqfootage)/@opamtdpanelcount).round(2)
        else @opaavgmtdpanelsqfootage = 0
        end

        if @mtdmaterialfootage > 0 then
            @avgmtdmaterialfootage = (Float(@mtdmaterialfootage)/@mtddays).round(2)
        else @avgmtdmaterialfootage = 0
        end

        if @wpamtdmaterialfootage > 0 then 
            @wpaavgmtdmaterialfootage = (Float(@wpamtdmaterialfootage)/@wpamtddays).round(2)
        else @wpaavgmtdmaterialfootage = 0
        end

        if @opamtdmaterialfootage > 0 then
            @opaavgmtdmaterialfootage = (Float(@opamtdmaterialfootage)/@opamtddays).round(2)
        else @opaavgmtdmaterialfootage = 0
        end

        if @mtdmaterialfootage > 0 then
            @avgpanelmtdmaterialfootage = (Float(@mtdmaterialfootage)/@mtdpanelcount).round(2)
        else @avgpanelmtdmaterialfootage = 0
        end

        if @wpamtdmaterialfootage > 0 then
            @wpaavgpanelmtdmaterialfootage = (Float(@wpamtdmaterialfootage)/@wpamtdpanelcount).round(2)
        else @wpaavgpanelmtdmaterialfootage = 0
        end

        if @opamtdmaterialfootage > 0 then
        @opaavgpanelmtdmaterialfootage = (Float(@opamtdmaterialfootage)/@opamtdpanelcount).round(2)
        else @opaavgpanelmtdmaterialfootage = 0
        end

# ##############    Sheathing Functions ################ #

        @sthwtdsqft = @wpawtdfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:sth_panel_sqft).to_f.round(2)
        @sthwtdpanelcount = @wpawtdfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:sth_count).to_i
        @sthwtddays = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND `wpa_production_summaries`.`sth_count` != 0").order(proddate: :desc).distinct.count("DATE(`proddate`)").to_i

        if @sthwtdsqft > 0 then
            @sthavgwtdpanelsqft = (@sthwtdsqft / @sthwtdpanelcount).to_f.round(2)
        else @sthavgwtdpanelsqft = 0
        end
        
        if @sthwtdsqft > 0 then 
            @sthavgwtdsqft = (@sthwtdsqft / @sthwtddays).to_f.round(2)
        else @sthavgwtdsqft = 0
        end
        
        if @sthwtdpanelcount > 0 then 
            @sthavgwtdpanelcount = (@sthwtdpanelcount / @sthwtddays).to_f.round(2)
        else @sthavgwtdpanelcount =  0
        end

        @sthmtdsqft = @wpawtdfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:sth_panel_sqft).to_f.round(2)
        @sthmtdpanelcount = @wpawtdfootage = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:sth_count).to_i
        @sthmtddays = WpaProductionSummaries.where("DATE(`wpa_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wpa_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND `wpa_production_summaries`.`sth_count` != 0").order(proddate: :desc).distinct.count("DATE(`proddate`)").to_i

        if @sthmtdsqft > 0 then
        @sthavgmtdpanelsqft = (@sthmtdsqft / @sthmtdpanelcount).to_f.round(2)
        else @sthavgmtdpanelsqft = 0
        end

        if @sthmtdsqft > 0 then
            @sthavgmtdsqft = (@sthmtdsqft / @sthmtddays).to_f.round(2)
        else @sthavgmtdsqft = 0
        end

        if @sthmtdpanelcount > 0
            @sthavgmtdpanelcount = (@sthmtdpanelcount / @sthmtddays).to_f.round(2)
        else @sthavgmtdpanelcount = 0
        end

# ##############    RollFormer Functions ################ #

        #@rfwtdfootage = ActiveRecord::Base.connection.select_value("SELECT rfGoodFt7Day(CURRENT_DATE)")
        #@rfwtdfootage = @rfwtdfootage.to_f
        # @wtdfootage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
        
        @rfwtdfootage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2)
        @rfsmwtdfootage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2)
        @rfacwtdfootage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2)
        @rfnuwtdfootage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2)
        #@rfwtdpoundage = ActiveRecord::Base.connection.select_value("SELECT rfGoodLbs7Day(CURRENT_DATE)")
        #@rfwtdpoundage = @rfwtdpoundage.to_f
        # @wtdpoundage = Wallpanels.where("(`wallpanels`.`status` = 'VRS' OR `wallpanels`.`status` = 'OPA')").joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        
        @rfwtdpoundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfsmwtdpoundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfacwtdpoundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfnuwtdpoundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    

        #@rfwtddays = ActiveRecord::Base.connection.select_value("SELECT rfWkDayCnt(CURRENT_DATE)")
        #@rfwtddays = @rfwtddays.to_i
        # @wtddays = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= ? AND DATE(`updated_at`) < ? AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')", Date.today-7.days, Date.today]).distinct.count("DATE(`updated_at`)")
        
        @rfwtddays = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").distinct.count("DATE(`proddate`)")
        @rfsmwtddays = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").distinct.count("DATE(`proddate`)")
        @rfacwtddays = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").distinct.count("DATE(`proddate`)")
        @rfnuwtddays = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").distinct.count("DATE(`proddate`)")

        if @rfwtdfootage > 0 then
            @rfavgwtdfootage = (Float(@rfwtdfootage)/@rfwtddays).round(2)
        else  @rfavgwtdfootage = 0
        end

        if @rfsmwtdfootage > 0 then
            @rfsmavgwtdfootage = (Float(@rfsmwtdfootage)/@rfsmwtddays).round(2)
        else @rfsmavgwtdfootage = 0
        end
        
        if @rfacwtdfootage > 0 then
            @rfacavgwtdfootage = (Float(@rfacwtdfootage)/@rfacwtddays).round(2)
        else @rfacavgwtdfootage = 0
        end
        
        if @rfnuwtdfootage > 0 then
            @rfnuavgwtdfootage = (Float(@rfnuwtdfootage)/@rfnuwtddays).round(2)
        else @rfnuavgwtdfootage = 0
        end


        if @rfwtdpoundage > 0 then
            @rfavgwtdpoundage = (Float(@rfwtdpoundage)/@rfwtddays).round(2)
        else @rfavgwtdpoundage = 0
        end

        if @rfsmwtdpoundage > 0 then
            @rfsmavgwtdpoundage = (Float(@rfsmwtdpoundage)/@rfsmwtddays).round(2)
        else @rfsmavgwtdpoundage = 0
        end

        if @rfacwtdpoundage > 0 then   
            @rfacavgwtdpoundage = (Float(@rfacwtdpoundage)/@rfacwtddays).round(2)
        else @rfacavgwtdpoundage = 0
        end

        if @rfnuwtdpoundage > 0 then      
            @rfnuavgwtdpoundage = (Float(@rfnuwtdpoundage)/@rfnuwtddays).round(2)
        else @rfnuavgwtdpoundage = 0
        end
        
        #@rfmtdfootage = ActiveRecord::Base.connection.select_value("SELECT rfGoodFt30Day(CURRENT_DATE)")
        #@rfmtdfootage = @rfmtdfootage.to_f
        # @mtdfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
         
        @rfmtdfootage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2)
        @rfsmmtdfootage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2)
        @rfacmtdfootage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2)
        @rfnumtdfootage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2)
        #@rfmtdpoundage = ActiveRecord::Base.connection.select_value("SELECT rfGoodLbs30Day(CURRENT_DATE)")
        #@rfmtdpoundage = @rfmtdpoundage.to_f
        # @mtdpoundage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        
        @rfmtdpoundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfsmmtdpoundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfacmtdpoundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfnumtdpoundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    


        #@rfmtddays = ActiveRecord::Base.connection.select_value("SELECT rfMthDayCnt(CURRENT_DATE)")
        #@rfmtddays = @rfmtddays.to_i
        # @mtddays = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= ? AND DATE(updated_at) < ? AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')", Date.today-30.days, Date.today]).distinct.count("DATE(`updated_at`)")
    
        @rfmtddays = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").distinct.count("DATE(`proddate`)")
        @rfsmmtddays = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").distinct.count("DATE(`proddate`)")
        @rfacmtddays = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").distinct.count("DATE(`proddate`)")
        @rfnumtddays = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").distinct.count("DATE(`proddate`)")

        if @rfmtdfootage > 0 then
            @rfavgmtdfootage = (Float(@rfmtdfootage)/@rfmtddays).round(2)
        else @rfavgmtdfootage = 0
        end

        if @rfsmmtdfootage > 0 then
            @rfsmavgmtdfootage = (Float(@rfsmmtdfootage)/@rfsmmtddays).round(2)
        else @rfsmavgmtdfootage = 0
        end

        if @rfacmtdfootage > 0 then
            @rfacavgmtdfootage = (Float(@rfacmtdfootage)/@rfacmtddays).round(2)
        else @rfacavgmtdfootage = 0
        end

        if @rfnumtdfootage > 0 then
            @rfnuavgmtdfootage = (Float(@rfnumtdfootage)/@rfnumtddays).round(2)
        else @rfnuavgmtdfootage = 0
        end


        if @rfmtdpoundage > 0 then
            @rfavgmtdpoundage = (Float(@rfmtdpoundage)/@rfmtddays).round(2)
        else @rfavgmtdpoundage = 0
        end

        if @rfsmmtdpoundage > 0 then
            @rfsmavgmtdpoundage = (Float(@rfsmmtdpoundage)/@rfsmmtddays).round(2)
        else @rfsmavgmtdpoundage = 0
        end

        if @rfacmtdpoundage > 0 then
            @rfacavgmtdpoundage = (Float(@rfacmtdpoundage)/@rfacmtddays).round(2)
        else @rfacavgmtdpoundage = 0
        end

        if @rfnumtdpoundage > 0 then
        @rfnuavgmtdpoundage = (Float(@rfnumtdpoundage)/@rfnumtddays).round(2)
        else @rfnuavgmtdpoundage = 0
        end
       # @rf60footage = ActiveRecord::Base.connection.select_value("SELECT rfGoodFt60Day(CURRENT_DATE)")
       # @rf60footage = @rf60footage.to_f
        # @mtdfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
       # @rf60poundage = ActiveRecord::Base.connection.select_value("SELECT rfGoodLbs60Day(CURRENT_DATE)")
       # @rf60poundage = @rf60poundage.to_f
        # @mtdpoundage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        
       # @rf60days = ActiveRecord::Base.connection.select_value("SELECT rf60DayCnt(CURRENT_DATE)")
       # @rf60days = @rf60days.to_i
        # @mtddays = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= ? AND DATE(updated_at) < ? AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')", Date.today-30.days, Date.today]).distinct.count("DATE(`updated_at`)")
    
       # @rfavg60footage = (Float(@rf60footage)/@rf60days).round(2)
       # @rfavg60poundage = (Float(@rf60poundage)/@rf60days).round(2)

        #@rf90footage = ActiveRecord::Base.connection.select_value("SELECT rfGoodFt90Day(CURRENT_DATE)")
        #@rf90footage = @rf90footage.to_f
        # @mtdfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
        
        @rf90footage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2) 
        @rfsm90footage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2) 
        @rfac90footage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2) 
        @rfnu90footage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2) 

        #@rf90poundage = ActiveRecord::Base.connection.select_value("SELECT rfGoodLbs90Day(CURRENT_DATE)")
        #@rf90poundage = @rf90poundage.to_f
        # @mtdpoundage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        
        @rf90poundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfsm90poundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfac90poundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfnu90poundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    

        #@rf90days = ActiveRecord::Base.connection.select_value("SELECT rf90DayCnt(CURRENT_DATE)")
        #@rf90days = @rf90days.to_i
        # @mtddays = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= ? AND DATE(updated_at) < ? AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')", Date.today-30.days, Date.today]).distinct.count("DATE(`updated_at`)")
    
        @rf90days = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").distinct.count("DATE(`proddate`)")
        @rfsm90days = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").distinct.count("DATE(`proddate`)")
        @rfac90days = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").distinct.count("DATE(`proddate`)")
        @rfnu90days = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").distinct.count("DATE(`proddate`)")

        if @rf90footage > 0 then
            @rfavg90footage = (Float(@rf90footage)/@rf90days).round(2)
        else @rfavg90footage = 0
        end

        if @rfsm90footage > 0 then
            @rfsmavg90footage = (Float(@rfsm90footage)/@rfsm90days).round(2)
        else @rfsmavg90footage = 0
        end

        if @rfac90footage > 0 then
            @rfacavg90footage = (Float(@rfac90footage)/@rfac90days).round(2)
        else @rfacavg90footage = 0
        end

        if @rfnu90footage > 0 then
            @rfnuavg90footage = (Float(@rfnu90footage)/@rfnu90days).round(2)
        else @rfnuavg90footage = 0
        end


        if @rf90poundage > 0 then
            @rfavg90poundage = (Float(@rf90poundage)/@rf90days).round(2)
        else @rfavg90poundage = 0
        end

        if @rfsm90poundage > 0 then
            @rfsmavg90poundage = (Float(@rfsm90poundage)/@rfsm90days).round(2)
        else @rfsmavg90poundage = 0
        end

        if @rfac90poundage > 0 then
            @rfacavg90poundage = (Float(@rfac90poundage)/@rfac90days).round(2)
        else @rfacavg90poundage = 0
        end

        if @rfnu90poundage > 0 then
            @rfnuavg90poundage = (Float(@rfnu90poundage)/@rfnu90days).round(2)
        else @rfnuavg90poundage = 0
        end

        #@rf120footage = ActiveRecord::Base.connection.select_value("SELECT rfGoodFt120Day(CURRENT_DATE)")
        #@rf120footage = @mtdfootage.to_f
            # @mtdfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
        #@rf120poundage = ActiveRecord::Base.connection.select_value("SELECT rfGoodLbs120Day(CURRENT_DATE)")
        #@rf120poundage = @mtdpoundage.to_f
            # @mtdpoundage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        
        #@rf120days = ActiveRecord::Base.connection.select_value("SELECT rf120DayCnt(CURRENT_DATE)")
        #@rf120days = @mtddays.to_i
            # @mtddays = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= ? AND DATE(updated_at) < ? AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')", Date.today-30.days, Date.today]).distinct.count("DATE(`updated_at`)")
    
        #@rfavg120footage = (Float(@rf120footage)/@rf120days).round(2)
        #@rfavg120poundage = (Float(@rf120poundage)/@rf120days).round(2)

        #@rf180footage = ActiveRecord::Base.connection.select_value("SELECT rfGoodFt180Day(CURRENT_DATE)")
        #@rf180footage = @rf180footage.to_f
        # @mtdfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
        
        @rf180footage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2) 
        @rfsm180footage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2) 
        @rfac180footage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2) 
        @rfnu180footage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2) 


        #@rf180poundage = ActiveRecord::Base.connection.select_value("SELECT rfGoodLbs180Day(CURRENT_DATE)")
        #@rf180poundage = @rf180oundage.to_f
        # @mtdpoundage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        
        @rf180poundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) ").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfsm180poundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfac180poundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)      
        @rfnu180poundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    

        #@rf180days = ActiveRecord::Base.connection.select_value("SELECT rf180DayCnt(CURRENT_DATE)")
        #@rf180days = @rf180days.to_i
        # @mtddays = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= ? AND DATE(updated_at) < ? AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')", Date.today-30.days, Date.today]).distinct.count("DATE(`updated_at`)")
   
        @rf180days = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").distinct.count("DATE(`proddate`)")
        @rfsm180days = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").distinct.count("DATE(`proddate`)")
        @rfac180days = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").distinct.count("DATE(`proddate`)")
        @rfnu180days = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").distinct.count("DATE(`proddate`)")

        if @rf180footage > 0 then
            @rfavg180footage = (Float(@rf180footage)/@rf180days).round(2)
        else @rfavg180footage = 0
        end

        if @rfsm180footage > 0 then
            @rfsmavg180footage = (Float(@rfsm180footage)/@rfsm180days).round(2)
        else @rfsmavg180footage = 0
        end


        if @rfac180footage > 0 then
            @rfacavg180footage = (Float(@rfac180footage)/@rfac180days).round(2)
        else @rfacavg180footage = 0
        end
        
        if @rfnu180footage > 0 then
            @rfnuavg180footage = (Float(@rfnu180footage)/@rfnu180days).round(2)
        else @rfnuavg180footage = 0
        end

        if @rf180poundage > 0 then
            @rfavg180poundage = (Float(@rf180poundage)/@rf180days).round(2)
        else @rfavg180poundage = 0
        end

        if @rfsm180poundage > 0 then
            @rfsmavg180poundage = (Float(@rf180poundage)/@rfsm180days).round(2)
        else @rfsmavg180poundage = 0
        end

        if @rfac180poundage > 0 then
            @rfacavg180poundage = (Float(@rfac180poundage)/@rfac180days).round(2)
        else @rfacavg180poundage = 0
        end

        if @rfnu180poundage > 0 then
            @rfnuavg180poundage = (Float(@rfnu180poundage)/@rfnu180days).round(2)
        else @rfnuavg180poundage = 0
        end


        #@rf365footage = ActiveRecord::Base.connection.select_value("SELECT rfGoodFt365Day(CURRENT_DATE)")
        #@rf365footage = @rf365footage.to_f
        # @mtdfootage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:length).to_f.round(2)
         
        @rf365footage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2)  
        @rfsm365footage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2)  
        @rfac365footage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2)  
        @rfnu365footage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").order(proddate: :desc).sum(:rlf_total_footage).to_f.round(2)  

        #@rf365poundage = ActiveRecord::Base.connection.select_value("SELECT rfGoodLbs365Day(CURRENT_DATE)")
        #@rf365poundage = @rf365poundage.to_f
        # @mtdpoundage = Wallpanels.joins("INNER JOIN `wallpanel_trackings` ON `wallpanels`.`id` = `wallpanel_trackings`.`wallpanels_id` AND DATE(`wallpanel_trackings`.`updated_at`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND DATE(`wallpanel_trackings`.`updated_at`) < DATE(CURRENT_DATE())").sum(:weight).to_f.round(2)
        
        @rf365poundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfsm365poundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfac365poundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    
        @rfnu365poundage = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").order(proddate: :desc).sum(:rlf_total_poundage).to_f.round(2)    

        #@rf365days = ActiveRecord::Base.connection.select_value("SELECT rf365DayCnt(CURRENT_DATE)")
        #@rf365days = @rf365days.to_i
        # @mtddays = WallpanelTracking.select("DATE(`updated_at`)").where(["DATE(`updated_at`) >= ? AND DATE(updated_at) < ? AND (`wallpanel_trackings`.`trans_code` = 'VRS' OR `wallpanel_trackings`.`trans_code` = 'OPA')", Date.today-30.days, Date.today]).distinct.count("DATE(`updated_at`)")
    
        @rf365days = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE())").distinct.count("DATE(`proddate`)")
        @rfsm365days = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 1").distinct.count("DATE(`proddate`)")
        @rfac365days = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 2").distinct.count("DATE(`proddate`)")
        @rfnu365days = RlfProductionSummaries.where("DATE(`rlf_production_summaries`.`proddate`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) AND DATE(`rlf_production_summaries`.`proddate`) < DATE(CURRENT_DATE()) AND workstations_id = 3").distinct.count("DATE(`proddate`)")

        if @rf365footage > 0 then
            @rfavg365footage = (Float(@rf365footage)/@rf365days).round(2)
        else @rfavg365footage = 0
        end

        if @rfsm365footage > 0 then
            @rfsmavg365footage = (Float(@rfsm365footage)/@rfsm365days).round(2)
        else @rfsmavg365footage = 0
        end

        if @rfac365footage > 0 then
            @rfacavg365footage = (Float(@rfac365footage)/@rfac365days).round(2)
        else @rfacavg365footage = 0
        end

        if @rfnu365footage > 0 then
            @rfnuavg365footage = (Float(@rfnu365footage)/@rfnu365days).round(2)
        else @rfnuavg365footage = 0
        end

        if @rf365poundage > 0 then
            @rfavg365poundage = (Float(@rf365poundage)/@rf365days).round(2)
        else @rfavg365poundage = 0
        end

        if @rfsm365poundage > 0 then
            @rfsmavg365poundage = (Float(@rfsm365poundage)/@rfsm365days).round(2)
        else @rfsmavg365poundage = 0
        end

        if @rfac365poundage > 0 then
            @rfacavg365poundage = (Float(@rfac365poundage)/@rfac365days).round(2)
        else @rfacavg365poundage = 0
        end

        if @rfnu365poundage > 0 then
            @rfnuavg365poundage = (Float(@rfnu365poundage)/@rfnu365days).round(2)
        else @rfnuavg365poundage = 0
        end

        @exportKeys = Wallpanels.select(:exportkey).distinct
  end

def wpaAll7Day
  respond_to do |format|               
    format.js
  end        
end 

private
  def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'dashboards',
                                             :sub_module => 'wall_panel_dash').first
      unless found_page_access
         flash[:alert] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems', :action => 'login')
      return false
      else return true
      end
  end

end
