class AllocationsController < ApplicationController
  layout 'mems'

  def index
  end

  def show
  #	@alloc = Allocations.where(item_masters_id: params[:item_masters_id], active: 1)
   @alloc = Allocations.find_by_sql(["SELECT AL.item_number, PWL.item_number profile, AL.alloc_to, SUM(AL.alloc_orig_qty) 
   	                                         alloc_orig_qty, SUM(AL.alloc_curr_qty) alloc_curr_qty, AL.alloc_type, AL.active, 
   	                                         AL.created_at, PHM.description phase_desc 
   	                                   FROM allocations AL 
   	                                   INNER JOIN pwo_lines PWL ON AL.alloc_to_id = PWL.id
   	                                   LEFT JOIN  pwo_headers PWH ON PWL.pwo_headers_id = PWH.id
   	                                   LEFT JOIN phase_masters PHM ON PWH.phase_masters_id = PHM.id 
   	                                   WHERE AL.active = 1 AND AL.item_masters_id = ? GROUP BY AL.alloc_to, PWL.item_number", params[:item_masters_id]])
  end
end
