class InvBalanceController < ApplicationController

  layout "mems"
  
  
  before_action :confirm_logged_in
  


  before_action :confirm_page_access

  def index
  end

  def showMMPL
  	 @company = params[:company]
  	 @gauge = params[:gauge]

	if session[:secgroup].include?('procure') || session[:secgroup].include?('admin') || session[:secgroup].include?('mgmt') and params[:fromDash] == 'true'
    	
    	@invtable = InvBalances.find_by_sql(["SELECT 
			IB.item_masters_id,
			IB.item_number,
			ROUND(IB.onhand, 2) ohFT,
				ROUND(IFNULL((SELECT SUM(IL.curr_qty * IC.lbsperfoot) 
				 			FROM inv_lots IL 
							INNER JOIN item_coils IC ON IL.item_masters_id = IC.item_masters_id
						    WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 0 and IL.active = 1
							GROUP BY IL.item_masters_id), 0.00),2) ohLBS,
				ROUND(IFNULL((SELECT SUM(IL.curr_qty * ICL.curr_cost) 
							 FROM inv_lots IL 
							 INNER JOIN inv_cost_layers ICL ON IL.lot = ICL.lotserial 
						     WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 0 and IL.active = 1
							 GROUP BY IL.item_masters_id), 0.00),2) ohVal,
			ROUND(IB.qa_hold_qty, 2) qaFT,
				ROUND(IFNULL((SELECT SUM(IL.curr_qty * IC.lbsperfoot) 
							FROM inv_lots IL 
							INNER JOIN item_coils IC ON IL.item_masters_id = IC.item_masters_id
						    WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 1 and IL.active = 1
							GROUP BY IL.item_masters_id), 0.00),2) qaLBS,
				ROUND(IFNULL((SELECT SUM(IL.curr_qty * ICL.curr_cost) 
				 			FROM inv_lots IL 
							INNER JOIN inv_cost_layers ICL ON IL.lot = ICL.lotserial 
						    WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 1 and IL.active = 1
						    GROUP BY IL.item_masters_id), 0.00),2) qaVal,
			ROUND(IB.onorder, 2) ooFT,
			    ROUND(IB.onorder * (IFNULL((SELECT (SUM(IL.curr_qty) / SUM(IL.curr_qty * ICL.curr_cost)) 
							FROM inv_lots IL 
							INNER JOIN inv_cost_layers ICL ON IL.lot = ICL.lotserial 
						    WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 0 and IL.active = 1
						    GROUP BY IL.item_masters_id), 0.00)),2) ooVal,
				ROUND(IB.onorder * (IFNULL((SELECT IC.lbsperfoot
				 			FROM item_coils IC 
      						WHERE IC.item_masters_id = IB.item_masters_id), 0.00)),2) ooLBS, 
			ROUND(IB.allocated, 2) alFT,
				ROUND(IB.allocated * (IFNULL((SELECT (SUM(IL.curr_qty) / SUM(IL.curr_qty * ICL.curr_cost)) 
							FROM inv_lots IL 
							INNER JOIN inv_cost_layers ICL ON IL.lot = ICL.lotserial 
						    WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 0 and IL.active = 1
						    GROUP BY IL.item_masters_id), 0.00)),2) alVal,
			    ROUND(IB.allocated * (IFNULL((SELECT IC.lbsperfoot
							FROM item_coils IC 
							WHERE IC.item_masters_id = IB.item_masters_id), 0.00)),2) alLBS, 
			ROUND(IB.available, 2) avFT,
			    ROUND(IB.available * (IFNULL((SELECT IC.lbsperfoot
							FROM item_coils IC 
							WHERE IB.item_masters_id = IC.item_masters_id), 0.00)),2) avLBS ,
     			ROUND(IB.available * (IFNULL((SELECT (SUM(IL.curr_qty * ICL.curr_cost) / SUM(IL.curr_qty)) 
							FROM inv_lots IL 
							INNER JOIN inv_cost_layers ICL ON IL.lot = ICL.lotserial 
						    WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 0 and IL.active = 1
						    GROUP BY IL.item_masters_id), 0.00)),2) avVal
		FROM inv_balances IB
		INNER JOIN item_coils ICA ON IB.item_masters_id = ICA.item_masters_id
		WHERE ICA.gauge = ?
		ORDER BY IB.item_number", params[:gauge]])
else
	@invtable = InvBalances.find_by_sql("SELECT 
			IB.item_masters_id,
			IB.item_number,
			ROUND(IB.onhand, 2) ohFT,
				ROUND(IFNULL((SELECT SUM(IL.curr_qty * IC.lbsperfoot) 
				 			FROM inv_lots IL 
							INNER JOIN item_coils IC ON IL.item_masters_id = IC.item_masters_id
						    WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 0 and IL.active = 1
							GROUP BY IL.item_masters_id), 0.00),2) ohLBS,
				ROUND(IFNULL((SELECT SUM(IL.curr_qty * ICL.curr_cost) 
							 FROM inv_lots IL 
							 INNER JOIN inv_cost_layers ICL ON IL.lot = ICL.lotserial 
						     WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 0 and IL.active = 1
							 GROUP BY IL.item_masters_id), 0.00),2) ohVal,
			ROUND(IB.qa_hold_qty, 2) qaFT,
				ROUND(IFNULL((SELECT SUM(IL.curr_qty * IC.lbsperfoot) 
							FROM inv_lots IL 
							INNER JOIN item_coils IC ON IL.item_masters_id = IC.item_masters_id
						    WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 1 and IL.active = 1
							GROUP BY IL.item_masters_id), 0.00),2) qaLBS,
				ROUND(IFNULL((SELECT SUM(IL.curr_qty * ICL.curr_cost) 
				 			FROM inv_lots IL 
							INNER JOIN inv_cost_layers ICL ON IL.lot = ICL.lotserial 
						    WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 1 and IL.active = 1
						    GROUP BY IL.item_masters_id), 0.00),2) qaVal,
			ROUND(IB.onorder, 2) ooFT,
			    ROUND(IB.onorder * (IFNULL((SELECT (SUM(IL.curr_qty) / SUM(IL.curr_qty * ICL.curr_cost)) 
							FROM inv_lots IL 
							INNER JOIN inv_cost_layers ICL ON IL.lot = ICL.lotserial 
						    WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 0 and IL.active = 1
						    GROUP BY IL.item_masters_id), 0.00)),2) ooVal,
				ROUND(IB.onorder * (IFNULL((SELECT IC.lbsperfoot
				 			FROM item_coils IC 
      						WHERE IC.item_masters_id = IB.item_masters_id), 0.00)),2) ooLBS, 
			ROUND(IB.allocated, 2) alFT,
				ROUND(IB.allocated * (IFNULL((SELECT (SUM(IL.curr_qty) / SUM(IL.curr_qty * ICL.curr_cost)) 
							FROM inv_lots IL 
							INNER JOIN inv_cost_layers ICL ON IL.lot = ICL.lotserial 
						    WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 0 and IL.active = 1
						    GROUP BY IL.item_masters_id), 0.00)),2) alVal,
			    ROUND(IB.allocated * (IFNULL((SELECT IC.lbsperfoot
							FROM item_coils IC 
							WHERE IC.item_masters_id = IB.item_masters_id), 0.00)),2) alLBS, 
			ROUND(IB.available, 2) avFT,
			    ROUND(IB.available * (IFNULL((SELECT IC.lbsperfoot
							FROM item_coils IC 
							WHERE IB.item_masters_id = IC.item_masters_id), 0.00)),2) avLBS ,
     			ROUND(IB.available * (IFNULL((SELECT (SUM(IL.curr_qty * ICL.curr_cost) / SUM(IL.curr_qty)) 
							FROM inv_lots IL 
							INNER JOIN inv_cost_layers ICL ON IL.lot = ICL.lotserial 
						    WHERE IL.item_masters_id = IB.item_masters_id AND IL.qa_hold = 0 and IL.active = 1
						    GROUP BY IL.item_masters_id), 0.00)),2) avVal
		FROM inv_balances IB
		INNER JOIN item_coils ICA ON IB.item_masters_id = ICA.item_masters_id
		ORDER BY IB.item_number")
	end

	respond_to do |format|
		format.html
		format.xls
	end
end


	def showMBSL
		@company = params[:company]
		@invtable = InvBalances.find_by_sql(["SELECT 
			IB.item_masters_id,
			IB.item_number,
			ROUND(IB.onhand, 2) ohFT,
			0.0000 ohLBS,
			ROUND(IFNULL((IB.onhand * 
				 (SELECT (SUM(ICL.curr_cost * ICL.curr_qty) / SUM(ICL.curr_qty)) 
						 FROM inv_cost_layers ICL
					     WHERE ICL.item_masters_id = IB.item_masters_id and ICL.active = 1
						 GROUP BY ICL.item_masters_id)), 0.00),2) ohVal,
			ROUND(IB.qa_hold_qty, 2) qaFT,
			0.0000 qaLBS,
			0.0000 qaVal,
			ROUND(IB.onorder, 2) ooFT,
		    0.0000 ooVal,
			0.0000 ooLBS, 
			ROUND(IB.allocated, 2) alFT,
			0.0000 alVal,
		    0.0000 alLBS, 
			ROUND(IB.available, 2) avFT,
		    0.0000 avLBS ,
 			0.0000 avVal
		FROM inv_balances IB
		INNER JOIN inv_balance_details IBD ON IB.id = IBD.inv_balances_id AND IBD.company = ? 
		ORDER BY IB.item_number", params[:company]])

		respond_to do |format|
			format.html
			format.xls
		end
	end


	def update

	end

private

def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id],
                                             :company => params[:company], 
                                             :module => 'inventory',
                                             :sub_module => 'invbalances',
                                             :access_page => 'summary').first
      unless found_page_access
         flash[:alert] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems', :action => 'login')
      return false
      else return true
      end
 end
end
