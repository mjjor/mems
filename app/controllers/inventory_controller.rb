class InventoryController < ApplicationController
  
    layout "mems"

      before_action :confirm_logged_in
      before_action :confirm_page_access

  def index

  end
   
  def dashboard
    @company = params[:company]
  	@gaugevalue = InvCostLayers.joins("INNER JOIN `item_coils` ON `inv_cost_layers`.`item_masters_id` = `item_coils`.`item_masters_id` 
   	                                    ").sum("`inv_cost_layers`.`curr_cost` * `inv_cost_layers`.`curr_qty`") 	
  	@gaugeweight = InvCostLayers.joins("INNER JOIN `item_coils` ON `inv_cost_layers`.`item_masters_id` = `item_coils`.`item_masters_id` 
   	                                    ").sum("`item_coils`.`lbsperfoot` * `inv_cost_layers`.`curr_qty`") 	
  	@gaugefootage = InvCostLayers.joins("INNER JOIN `item_coils` ON `inv_cost_layers`.`item_masters_id` = `item_coils`.`item_masters_id` 
   	                                    ").sum("`inv_cost_layers`.`curr_qty`") 	  	
    @invtots = ItemCoils.find_by_sql("SELECT 
                                      IB.item_number,
                                      ICA.gauge gauge,
                                      ROUND(SUM(IB.onhand),2) ohFT,  
                                      ROUND(SUM(IB.onhand * ICA.lbsperfoot),2) ohLBS, 
                                        ROUND(SUM(IB.onhand) * IFNULL((SELECT SUM(ICL.curr_qty * ICL.curr_cost) / SUM(ICL.curr_qty) 
                                        FROM inv_cost_layers ICL  
                                        INNER JOIN item_coils ICC ON ICL.item_masters_id = ICC.item_masters_id
                                        WHERE ICC.gauge = ICA.gauge AND ICL.active = 1
                                        GROUP BY ICC.gauge), 0.00),2) ohVal,
                                      ROUND(SUM(IB.qa_hold_qty),2) qaFT,
                                      ROUND(SUM(IB.qa_hold_qty * ICA.lbsperfoot),2) qaLBS,
                                        ROUND(SUM(IB.qa_hold_qty) * IFNULL((SELECT SUM(ICL.curr_qty * ICL.curr_cost) / SUM(ICL.curr_qty) 
                                        FROM inv_cost_layers ICL  
                                        INNER JOIN item_coils ICC ON ICL.item_masters_id = ICC.item_masters_id
                                        WHERE ICC.gauge = ICA.gauge AND ICL.active = 1
                                        GROUP BY ICC.gauge), 0.00), 2) qaVal,
                                      SUM(IB.onorder) ooFT,
                                        ROUND(IB.onorder * (IFNULL((SELECT (SUM(IL.curr_qty) / SUM(IL.curr_qty * ICL.curr_cost)) 
                                          FROM inv_lots IL 
                                          INNER JOIN inv_cost_layers ICL ON IL.lot = ICL.lotserial 
                                          INNER JOIN item_coils ICF ON IL.item_masters_id = ICF.item_masters_id
                                          WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 0 and IL.active = 1
                                          GROUP BY ICF.gauge), 0.00)),2) ooVal,
                                        ROUND(IB.onorder * (IFNULL((SELECT ICG.lbsperfoot
                                          FROM item_coils ICG 
                                          WHERE ICG.item_masters_id = IB.item_masters_id
                                          GROUP BY ICG.gauge), 0.00)),2) ooLBS, 
                                      SUM(IB.allocated) alFT,
                                        ROUND(IB.allocated * (IFNULL((SELECT (SUM(IL.curr_qty) / SUM(IL.curr_qty * ICL.curr_cost)) 
                                          FROM inv_lots IL 
                                          INNER JOIN inv_cost_layers ICL ON IL.lot = ICL.lotserial 
                                          INNER JOIN item_coils ICH ON IL.item_masters_id = ICH.item_masters_id
                                          WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 0 and IL.active = 1
                                          GROUP BY ICH.gauge), 0.00)),2) alVal,
                                        ROUND(IB.allocated * (IFNULL((SELECT ICI.lbsperfoot
                                          FROM item_coils ICI 
                                          WHERE ICI.item_masters_id = IB.item_masters_id
                                          GROUP BY ICI.gauge), 0.00)),2) alLBS, 
                                      SUM(IB.available) avFT,
                                        ROUND(IB.available * (IFNULL((SELECT ICJ.lbsperfoot
                                          FROM item_coils ICJ 
                                          WHERE IB.item_masters_id = ICJ.item_masters_id
                                          GROUP BY ICJ.gauge), 0.00)),2) avLBS ,
                                        ROUND(IB.available * (IFNULL((SELECT (SUM(IL.curr_qty * ICL.curr_cost) / SUM(IL.curr_qty)) 
                                          FROM inv_lots IL 
                                          INNER JOIN inv_cost_layers ICL ON IL.lot = ICL.lotserial 
                                          INNER JOIN item_coils ICK ON IL.item_masters_id = ICK.item_masters_id
                                          WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 0 and IL.active = 1
                                          GROUP BY ICK.gauge), 0.00)),2) avVal
                                      FROM inv_balances IB
                                      INNER JOIN item_coils ICA ON IB.item_masters_id = ICA.item_masters_id 
                                      GROUP BY ICA.gauge")
    respond_to do |format|
        format.html
        format.xls
      end
  end 	

  def show
  end

private
def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'inventory',
                                             :sub_module => 'dashboard',
                                             :access_page => 'coil').first
      unless found_page_access
         flash[:notice] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems_login', :action => 'index.html')
      return false
      else return true
      end
 end
  
end
