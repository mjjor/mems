class ItemLedgersController < ApplicationController
  def index
  end

 	def view
	  	@company = params[:company]
	  	@procure = params[:procure]
	  	@itemnumber = params[:item_number]
	  	case params[:callprog]
	        when "invbal"
		    	@itemledger = ItemLedgers.find_by_sql(["SELECT 
					IL.id, IL.item_masters_id, IL.transcode, IL.document_num, IL.quantity, IL.updated_at, 
					IL.lotserial, IL.created_at, IL.openbal, IL.closebal 
					FROM item_ledgers IL
					WHERE IL.company = ? AND IL.item_masters_id = ? 
					ORDER BY IL.id DESC ", @company, params[:item_masters_id]])	
	    	when "invlot"
				@invtable = ItemLedgers.find_by_sql(["SELECT 
					IL.id, IL.item_masters_id, IL.transcode, IL.document_num, IL.quantity, IL.updated_at, 
					IL.lotserial, IL.created_at
					FROM item_ledgers IL
					WHERE IL.company = ? AND IL.item_masters_id = ? AND IL.lotserial = ? 
					ORDER BY IL.id DESC", @company, params[:item_masters_id], params[:lot]])
	   	end
		respond_to do |format|
			format.html
			format.xls
		end
 	end

	def edit
	end

	def update
	end
end
