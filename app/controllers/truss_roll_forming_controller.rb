class TrussRollFormingController < ApplicationController
  before_action :confirm_logged_in
  before_action :confirm_page_access

    layout "mems"

  def index
  	@truss = TrussTracking.new
  	@trans_code = params[:trans_code]
    @currcoil   = CurrentCoils.where(workstations_id: params[:workstation], is_active: true).limit(1).pluck(:inv_lots_id, :workstations_id)
   # @invcoil = InvLots.where(id: @currcoil[0]).limit(1).pluck(:lot, :curr_qty)
    @lot =  InvLots.where(id: @currcoil[0]).limit(1).pluck(:lot).join(" ")
    @coilcurrqty = InvLots.where(id: @currcoil[0]).limit(1).pluck(:curr_qty).join(" ")
  end

  def create
     @truss = TrussTracking.where(trusslabel: truss_params[:trusslabel]).first_or_initialize
     @trid  = Trusses.where(trusslabel: truss_params[:trusslabel]).limit(1).pluck(:id)
     prodprocessed = Trusses.where(trusslabel: truss_params[:trusslabel]).pluck(:production_sent).join(" ")
	   @truss.trusses_id = @trid[:id[0].to_i]
     @truss.trusslabel = truss_params[:trusslabel]
     @truss.trans_code = truss_params[:trans_code]
     @truss.users_id   = session[:user_id]
     @truss.save
      if @truss.save
        @uname = Users.where(id: session[:user_id]).limit(1).pluck(:firstname, :lastname).join(" ")
        @currcoil   = CurrentCoils.where(workstations_id: truss_params[:workstation], is_active: true).limit(1).pluck(:inv_lots_id)
        @prevlot = InvLots.where(id: @currcoil).limit(1).pluck(:lot)
           
        @previtem = InvLots.where(id: @currcoil).limit(1).pluck(:item_masters_id) 
        @itemname = ItemMasters.where(id: @previtem).limit(1).pluck(:item_number)

        updtruss = Trusses.find(@trid[0].to_i)
        updtruss.status = @truss.trans_code
        updtruss.is_active = 0
        updtruss.production_sent = 1
        updtruss.coil_id = @currcoil.at(0)
        updtruss.coil_material = @itemname.at(0)
        @materialuse = updtruss.footage
        @order = "#{updtruss.project}-#{updtruss.phase}"
        @trans_code = @truss.trans_code
        updtruss.save
      if updtruss.save
        if (prodprocessed) == "false"
          @coil = CurrentCoils.new 
          @prevcoil = CurrentCoils.where(workstations_id: truss_params[:workstation], is_active: true).limit(1).pluck(:inv_lots_id)
          @prevlot = InvLots.where(id: @prevcoil).limit(1).pluck(:lot)
           
          @previtem = InvLots.where(id: @prevcoil).limit(1).pluck(:item_masters_id) 
          @itemname = ItemMasters.where(id: @previtem).limit(1).pluck(:item_number)

          @uname = Users.where(id: session[:user_id]).limit(1).pluck(:firstname, :lastname).join(" ") 

          @prodimport = EclipseImports.new
          @prodimport.type = "1"
          @prodimport.reason = "M"
          @prodimport.good_footage = (@materialuse * 12)
          @prodimport.scrap_footage = 0.0000
          cDate = Time.new
          sDate = Time.new(1980, 01,01,0,0,0,"-00:00")
          cMins = (cDate.to_i / 60) - (sDate.to_i / 60)
          @prodimport.date = cDate.strftime("%F")
          @prodimport.time = cDate.strftime("%T")
          @prodimport.minutes = cMins
          @prodimport.production_date = cDate.strftime("%F")
          @prodimport.shift = "1"
          @prodimport.machine = "3"
          @prodimport.order_number = @order 
          @prodimport.material = @itemname[0]
          @prodimport.product_code = "Truss-#{updtruss.trussid}"
          @prodimport.customer_name = "MAGEST BUILDING SYSTEMS lTD."
          @prodimport.inv_coil = @prevlot.at(0)
          @prodimport.coil_material = @itemname.at(0)
          @prodimport.coil_width = 8.730
          @prodimport.processed = 'n'
          @prodimport.employee_id = session[:user_id]
          @prodimport.importfile = "Nucon Export"
          @prodimport.work_order_nbr = ""
          @prodimport.order_type = ""
          @prodimport.part_option = ""
          @prodimport.part_number = "PRINTONLY"
          @prodimport.pattern = ""
          @prodimport.heat_number = ""
          @prodimport.code_type = ""
          @prodimport.code_description = ""
          @prodimport.code_exempt = ""
          @prodimport.machine_status = ""
          @prodimport.employee_name = @uname
          @prodimport.item_id = ""
          @prodimport.list_text = ""
          @prodimport.plant_name = "MAGEST METAL PRODUCTS LTD."
          @prodimport.code_responsibility_type = ""
          @prodimport.bundle_code = ""
          @prodimport.save
        end
         @truss.touch
         flash[:notice] = "Truss processed successfully!"
         redirect_to(:action => 'index', :trans_code => @truss.trans_code, :workstation => 3)
       end
      else
         flash[:alert] = "Last truss scanned not processed"
        redirect_to(:action => 'index', :trans_code => @truss.trans_code, :workstation => 3)
      end
	end

  def show
    case params[:scanned]
      when 'scanned' then
        @scannedtoday = Trusses.where("(trusses.status != 'open' AND trusses.status != ' ')").joins("INNER JOIN `truss_trackings` ON `trusses`.`id` = `truss_trackings`.`trusses_id` AND DATE(truss_trackings.updated_at) >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)").lastupdate
      when 'unscanned' then
        @scannedtoday = Trusses.where(:status => 'open').oldestupdate
    end
  end
 
private

def truss_params
    params.require(:truss_tracking).permit(:trusslabel, :trans_code, :users_id, :trusses_id, :workstation, :scanned)
end

def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'production',
                                             :sub_module => 'truss_rollformer',
                                             :access_page => 'truss_scan').first
      unless found_page_access
         flash[:alert] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems', :action => 'login')
      return false
      else return true
      end
  end

end
