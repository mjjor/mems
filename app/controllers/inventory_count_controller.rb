class InventoryCountController < ApplicationController
  
	layout "mems"

  before_action :confirm_logged_in
  before_action :confirm_page_access

  def index
  end

  def coil
    @count_master = InvCountMasters.find_by("valid_companies LIKE ? AND is_active = ?", "%#{params[:company]}%", 1)
    @itemcateg = params[:itemcateg]
    @coilcount = InventoryCounts.new
  end

  def coil_update
    @notfound = true
    @company = params[:inventory_counts][:company]
    @itemcateg = params[:inventory_counts][:itemcateg]
    @count_master = InvCountMasters.find_by("valid_companies LIKE ? AND is_active = ?", "%#{params[:company]}%", 1)
    @count_cycle = @count_master.coil_cycle
    @coil = InventoryCounts.find_by(:lotserial => params[:inventory_counts][:lotserial])

    if !@coil.nil?  
      @notfound = false
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
       @coilsaved = true
    else @coilsaved = false  
    end  
  end
  if !@notfound && @coilsaved 
      flash[:notice] = "Count Recorded Successfully!"
      redirect_to(:action => 'coil', :company => params[:inventory_counts][:company], :itemcateg => params[:inventory_counts][:itemcateg])
  else
    flash[:notice] = "*** LAST COIL NOT RECORDED ***"
    # @company = @company
    # @itemcateg = @itemcateg    
    redirect_to(:action => 'coil', :company => params[:inventory_counts][:company], :itemcateg => params[:inventory_counts][:itemcateg])
    #render('coil') 
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
                  @invcount.count_1_cost_variance = (((params[:sheet][:count_1_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) * @invcount.unit_cost) 
                  @invcount.item_inv_unit_variance = ((params[:sheet][:count_1_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) 
                  @invcount.item_cost_variance = (((params[:sheet][:count_1_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) * @invcount.unit_cost) 
                else 
                  @invcount.count_1_quantity = @invcount.count_1_quantity + params[:sheet][:count_1_qty].to_i
                  @invcount.count_1_inv_qty = (@invcount.count_1_quantity.to_i * @invcount.inv_uom_cnv)
                  @invcount.count_1_variance = ((@invcount.count_1_quantity.to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) 
                  @invcount.count_1_cost_variance = (((@invcount.count_1_quantity.to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) * @invcount.unit_cost) 
                  @invcount.item_inv_unit_variance = ((@invcount.count_1_quantity.to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) 
                  @invcount.item_cost_variance = (((@invcount.count_1_quantity.to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) * @invcount.unit_cost) 
			          end
                  @invcount.updated_by = session[:user_id]                
                  @invcount.count_1 = 1  
    when 2 then 
                if (params[:sheet][:count_2_qty] == "0")
                  @invcount.count_2_quantity =  params[:sheet][:count_2_qty].to_i
                  @invcount.count_2_inv_qty = (params[:sheet][:count_2_qty].to_i * @invcount.inv_uom_cnv)
                  @invcount.count_2_variance = ((params[:sheet][:count_2_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) 
                  @invcount.count_2_cost_variance = (((params[:sheet][:count_2_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) * @invcount.unit_cost)
                  @invcount.item_inv_unit_variance = ((params[:sheet][:count_2_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) 
                  @invcount.item_cost_variance = (((params[:sheet][:count_2_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) * @invcount.unit_cost)
                else 
                  @invcount.count_2_quantity = @invcount.count_2_quantity + params[:sheet][:count_2_qty].to_i
                  @invcount.count_2_inv_qty = (@invcount.count_2_quantity.to_i * @invcount.inv_uom_cnv) 
                  @invcount.count_2_variance = ((@invcount.count_2_quantity.to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance)
                  @invcount.count_2_cost_variance = (((@invcount.count_2_quantity.to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) * @invcount.unit_cost)
                  @invcount.item_inv_unit_variance = ((@invcount.count_1_quantity.to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) 
                  @invcount.item_cost_variance = (((@invcount.count_1_quantity.to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) * @invcount.unit_cost)
                end
                  @invcount.updated_by = session[:user_id]
                  @invcount.count_2 = 1 
		when 3 then 
                if (params[:sheet][:count_3_qty] == "0")
                  @invcount.count_3_quantity =  params[:sheet][:count_3_qty].to_i
                  @invcount.count_3_inv_qty = (params[:sheet][:count_3_qty].to_i * @invcount.inv_uom_cnv)
                  @invcount.count_3_variance = ((params[:sheet][:count_3_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) 
                  @invcount.count_3_cost_variance = (((params[:sheet][:count_3_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) * @invcount.unit_cost)
                  @invcount.item_inv_unit_variance = ((params[:sheet][:count_3_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) 
                  @invcount.item_cost_variance = (((params[:sheet][:count_3_qty].to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) * @invcount.unit_cost) 

                else 
                  @invcount.count_3_quantity = (@invcount.count_3_quantity + params[:sheet][:count_3_qty].to_i)
                  @invcount.count_3_inv_qty = (@invcount.count_3_quantity.to_i * @invcount.inv_uom_cnv)
                  @invcount.count_3_variance = ((@invcount.count_3_quantity.to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance)
                  @invcount.count_3_cost_variance = (((@invcount.count_3_quantity.to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) * @invcount.unit_cost)
                  @invcount.item_inv_unit_variance = ((@invcount.count_1_quantity.to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) 
                  @invcount.item_cost_variance = (((@invcount.count_1_quantity.to_i * @invcount.inv_uom_cnv) - @invcount.opening_balance) * @invcount.unit_cost)
                end	
                  @invcount.updated_by = session[:user_id]
                  @invcount.count_3 = 1
  end

	@invcount.save
  if @invcount.save
		flash[:notice] = "Count Recorded Successfully!"
        redirect_to(:action => 'flatstock', :company => params[:sheet][:company], :itemcateg => params[:sheet][:itemcateg])
      else
         flash[:alert] = "Last count NOT processed" 
        render('flatstock')
      end
  end	
  
  def sheathing
  end

  def view_count
    @count_master = InvCountMasters.find_by("is_active = ?", 1)
    # @count_cycle = @count_master.sheetsteel_cycle
    if !@count_master.nil?
    @count = InventoryCounts.where(:inv_count_masters_id => @count_master[:id]).updated
    else
    flash[:alert] = "No Active Count in Progress"
        redirect_to(:controller => 'admin', :action => 'index')  
    end 

  end

private

def count_params
   params.require(:inventory_counts).permit(:company, :item_number, :sheet_part, :count_1, :count_2, :count_3, 
                                            :count_1_qty, :count_2_qty, :count_1_variance, :count_2_variance, 
                                            :count_3_variance, :count_3_qty, :lotserial) 
end

private
def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'inventory',
                                             :sub_module => 'invcount',
                                             :access_page => 'count').first
      unless found_page_access
         flash[:alert] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems', :action => 'login')
      return false
      else return true
      end
 end

end
