class CurrentCoilController < ApplicationController
 
  	before_action :confirm_logged_in
  	before_action :confirm_page_access

    layout "mems"

  def index
  	@coil = CurrentCoils.new 
    # CurrentCoils.where(workstations_id: 3).limit(1).pluck(:lot, :inv_lots_id, :workstations_id)
    # CurrentCoils.where(workstations_id: params[:workstation]).first_or_initialize
    # @currcoil = @coil[0]
    # @station = params[:workstation]
  end

  def edit
  	@invcoil = InvLots.where(lot: coil_params[:lot]).limit(1).pluck(:id, :lot, :curr_qty).join(" ")
    
    #@coil = CurrentCoils.where(workstations_id: coil_params[:station] and active: true).first_or_initialize
    
    @prevcc = CurrentCoils.where(workstations_id: coil_params[:station], is_active: true).first_or_initialize
    @prevcoil = CurrentCoils.where(workstations_id: coil_params[:station], is_active: true).limit(1).pluck(:inv_lots_id)
    @prevcard  = CurrentCoils.where(workstations_id: coil_params[:station], is_active: true).limit(1).pluck(:smartcard)
    
    @prevlot   = InvLots.where(id: @prevcoil).limit(1).pluck(:lot)
    @previtem = InvLots.where(id: @prevcoil).limit(1).pluck(:item_masters_id)
    
    @itemname = ItemMasters.where(id: @previtem[0]).limit(1).pluck(:item_number)
    
    @workstation = Workstations.where(id: coil_params[:station]).limit(1).pluck(:workstation).join(" ")
    
    @uname = Users.where(id: session[:user_id]).limit(1).pluck(:firstname, :lastname).join(" ") 
    
    @prevcc.is_active = false
    @prevcc.save

    @newcoil = CurrentCoils.new 
    @newcoil.inv_lots_id = InvLots.where(lot: coil_params[:lot]).limit(1).pluck(:id).join(" ")
    @newcoil.lot = InvLots.where(lot: coil_params[:lot]).limit(1).pluck(:lot).join(" ")
    @newcoil.workstations_id = coil_params[:station]
    @newcoil.workstation = Workstations.where(id: coil_params[:station]).limit(1).pluck(:workstation).join(" ")
    @newcoil.smartcard_reading = coil_params[:smartcard_reading]
    @newcoil.save
    if @newcoil.save
       if coil_params[:coil_complete] == "0"
          @prodimport = EclipseImports.new
          @prodimport.type = "2"
          @prodimport.reason = "D"
          cDate = Time.new
          sDate = Time.new(1980, 01,01,0,0,0,"-00:00")
          cMins = (cDate.to_i / 60) - (sDate.to_i / 60)
          @prodimport.date = cDate.strftime("%F")
          @prodimport.time = cDate.strftime("%T")
          @prodimport.minutes = cMins
          @prodimport.production_date = cDate.strftime("%F")
          @prodimport.shift = "1"
          @prodimport.machine = "3"
          @prodimport.order_number = "Nucon Truss Job" 
          @prodimport.material = @itemname[0]
          @prodimport.product_code = "Truss"
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
          @prodimport.part_number = ""
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
     flash[:notice] = "Coil Changed Successfully!"
         redirect_to(:controller => 'truss_roll_forming', :action => 'index', :trans_code => 'NCN', :workstation => 3)
      else
         flash[:notice] = "COIL CHANGE FAILED"
        render('index', :trans_code => 'NCN', :workstation => 3)
      end
    @currqty = @invcoil[2]
    @lot = @invcoil[1]

  end 

private

  def coil_params
    params.require(:current_coils).permit(:lot, :station, :coil_complete, :smartcard_reading)
  end

def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'production',
                                             :sub_module => 'truss_rollformer',
                                             :access_page => 'change_coil').first
      unless found_page_access
         flash[:notice] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems_login', :action => 'index.html')
      return false
      else return true
      end
  end

end
