class InventoryCountController < ApplicationController
  
	layout "mems"

  def index
  end

  def coil
    @count_master = InvCountMasters.find_by("valid_companies LIKE ? AND is_active = ?", "%#{params[:company]}%", 1)
    @itemcateg = params[:itemcateg]
    @coilcount = InventoryCounts.new
  end

  def coil_update
    @count_master = InvCountMasters.find_by("valid_companies LIKE ? AND is_active = ?", "%#{params[:company]}%", 1)
    @count_cycle = @count_master.coil_cycle
    @coil = InventoryCounts.find_by(:lotserial => params[:inventory_counts][:lotserial])
    case @count_cycle
      when 1 then
          @coil.count_1 = 1
          @coil.count_1_quantity = @coil.opening_balance
          @coil.count_1_inv_qty = (@coil.opening_balance * @coil.inv_uom_cnv)
          @coil.count_1_variance = 0.0000 
          @coil.updated_by = session[:user_id]
      when 2 then
          @coil.count_2 = 1
          @coil.count_2_quantity = @coil.opening_balance
          @coil.count_2_inv_qty = (@coil.opening_balance * @coil.inv_uom_cnv)
          @coil.count_2_variance = 0.0000 
          @coil.updated_by = session[:user_id]
      when 3 then
          @coil.count_3 = 1
          @coil.count_3_quantity = @coil.opening_balance
          @coil.count_3_inv_qty = (@coil.opening_balance * @coil.inv_uom_cnv)
          @coil.count_3_variance = 0.0000 
          @coil.updated_by = session[:user_id]
    end
    @coil.save
  if @coil.save
    flash[:notice] = "Count Recorded Successfully!"
        redirect_to(:action => 'coil', :company => params[:company], :itemcateg => params[:inventory_counts][:itemcateg])
      else
         flash[:notice] = "*** LAST COUNT NOT PROCESSED ***" 
        render('flatstock')
      end

  end

  def flatstock
  	@count_master = InvCountMasters.find_by("valid_companies LIKE ? AND is_active = ?", "%#{params[:company]}%", 1)
    @itemcateg = params[:itemcateg]

    case params[:itemcateg]
      when 'STH' then
        @count_cycle = @count_master.sheetsteel_cycle
        @fstock = InventoryCounts.where(:company => params[:company], :item_class => 'SHEATHING').itemdesc  
      when 'SHS' then 
        @count_cycle = @count_master.sheetsteel_cycle
  	    @fstock = InventoryCounts.where(:company => params[:company], :item_class => 'FLAT STOCK').itemdesc
      when 'MSC' then
        @count_cycle = @count_master.sheetsteel_cycle
        @fstock = InventoryCounts.where(:company => params[:company], :item_class => 'MISCITEM').itemdesc  
    end
  end

  def flatstock_update
  
    @invcount = InventoryCounts.find_by(:company => params[:sheet][:company], :item_number => params[:sheet][:sheetpart])
	
  case params[:sheet][:count_cycle].to_i
		when 1 then 
                if (params[:sheet][:count_1_qty] == "0")
                  @invcount.count_1_quantity =  params[:sheet][:count_1_qty].to_i
                  @invcount.count_1_inv_qty = (params[:sheet][:count_1_qty].to_i * @invcount.inv_uom_cnv)
                  @invcount.count_1_variance = ((params[:sheet][:count_1_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) 
                  @invcount.updated_by = session[:user_id]
                else 
                  @invcount.count_1_quantity = @invcount.count_1_quantity + params[:sheet][:count_1_qty].to_i
                  @invcount.count_1_inv_qty = ((@invcount.count_1_quantity + params[:sheet][:count_1_qty].to_i) * @invcount.inv_uom_cnv)
                  @invcount.count_1_variance = ((@invcount.count_1_quantity + params[:sheet][:count_1_qty].to_i) * (@invcount.inv_uom_cnv - @invcount.opening_balance)) 
                  @invcount.updated_by = session[:user_id]
			          end
                  @invcount.count_1 = 1  
    when 2 then 
                if (params[:sheet][:count_2_qty] == "0")
                  @invcount.count_2_quantity =  params[:sheet][:count_1_qty].to_i
                  @invcount.count_2_inv_qty = (params[:sheet][:count_2_qty].to_i * @invcount.inv_uom_cnv)
                  @invcount.count_2_variance = ((params[:sheet][:count_2_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) 
                  @invcount.updated_by = session[:user_id]
                else 
                  @invcount.count_2_quantity = @invcount.count_2_quantity + params[:sheet][:count_2_qty].to_i
                  @invcount.count_2_inv_qty = ((@invcount.count_2_quantity + params[:sheet][:count_2_qty].to_i) * @invcount.inv_uom_cnv) 
                  @invcount.count_2_variance = (((@invcount.count_2_quantity + params[:sheet][:count_2_qty].to_i) * @invcount.inv_uom_cnv) - @invcount.opening_balance)
                  @invcount.updated_by = session[:user_id]
                end
                  @invcount.count_2 = 1 
		when 3 then 
                if (params[:sheet][:count_1_qty] == "0")
                  @invcount.count_1_quantity =  params[:sheet][:count_1_qty].to_i
                  @invcount.count_1_inv_qty = (params[:sheet][:count_1_qty].to_i * @invcount.inv_uom_cnv)
                  @invcount.count_1_variance = ((params[:sheet][:count_1_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) 
                  @invcount.updated_by = session[:user_id]
                else 
                  @invcount.count_3_quantity = (@invcount.count_3_quantity + params[:sheet][:count_3_qty].to_i)
                  @invcount.count_3_inv_qty = ((@invcount.count_3_quantity + params[:sheet][:count_3_qty].to_i) * @invcount.inv_uom_cnv)
                  @invcount.count_3_variance = (((@invcount.count_3_quantity + params[:sheet][:count_3_qty].to_i) * @invcount.inv_uom_cnv) - @invcount.opening_balance)
                  @invcount.updated_by = session[:user_id]
                end	
                  @invcount.count_3 = 1
  end

	@invcount.save
  if @invcount.save
		flash[:notice] = "Count Recorded Successfully!"
        redirect_to(:action => 'flatstock', :company => params[:sheet][:company], :itemcateg => params[:sheet][:itemcateg])
      else
         flash[:notice] = "*** LAST COUNT NOT PROCESSED ***" 
        render('flatstock')
      end
  end	
  
  def sheathing
  end

  def view_count
    @count_master = InvCountMasters.find_by("is_active = ?", 1)
    @count_cycle = @count_master.sheetsteel_cycle
    @count = InventoryCounts.where(:inv_count_masters_id => @count_master[:id]).updated
  end

private

def sheet_params
   params.require(:inventory_counts).permit([:sheet][:company], [:sheet][:item_number], [:sheet][:sheet_part], 
                                            [:sheet][:count_1], [:sheet][:count_2], [:sheet][:count_3], 
                                            [:sheet][:count_1_qty], [:sheet][:count_2_qty], [:sheet][:count_3_qty]) 
end



end
