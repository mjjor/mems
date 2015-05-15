class RollformerQaCheckController < ApplicationController
  
  layout "mems"

  before_action :confirm_logged_in
  before_action :confirm_page_access
  
  respond_to :json

  def index
    @pwo = PwoHeaders.select(:pwo_worderno, :id).where(:status => [1,2], :workstations_id => 1).wosorted
    @profiles = PwoLines.where("pwo_headers_id = ?", PwoHeaders.first.id).group(:item_number).itmsorted
    @pcemarks = PwoLines.where("pwo_headers_id = ?", PwoHeaders.first.id).group(:piecemark).pmsorted
  end

  def new
     @newrollformqa = RollformerQaChecks.new
  	 @pwolinelength = PwoLines.where(:id => params[:member][:pcemark_id]).pluck(:length).join(" ")
     @pwolinepmark  = PwoLines.where(:id => params[:member][:pcemark_id]).pluck(:piecemark).join(" ")
     @pwolineitemnum = PwoLines.where(:id => params[:member][:pcemark_id]).pluck(:item_number).join(" ")
     @newrollformqa.pwo_headers_id = params[:member][:header_id]
     @newrollformqa.pwo_lines_id = params[:member][:pcemark_id]
     @newrollformqa.item_number =  params[:member][:member_id] 
     @newrollformqa.piecemark = @pwolinepmark
     @newrollformqa.required_length = @pwolinelength 
     @newrollformqa.save
     if @newrollformqa.save
        @itemnum = PwoLines.select(:item_number).find(params[:member][:pcemark_id])
        redirect_to(:action => 'show', :newid => @newrollformqa.id, :itemnum => params[:member][:member_id] , 
                                       :reqlength => @pwolinelength, :pmark => @pwolinepmark)
     end
  end

  def show
    @rollformqa = RollformerQaChecks.find_by("id = ?", params[:newid])
  end

def edit
    @rollformqa = RollformerQaChecks.find_by("id = ?", params[:qaform][:formid].to_i)
    @rollformqa.company = params[:qaform][:company]
    @rollformqa.workstations_id = params[:qaform][:workstation]
    @rollformqa.warehouses_id = params[:qaform][:warehouse]
    @rollformqa.coilid = params[:qaform][:coilid]
    @rollformqa.hole_center_width_A = params[:qaform][:hole_center_width_A].split.map {|r| Rational(r) }.inject(:+).to_f
    @rollformqa.hole_center_width_B = params[:qaform][:hole_center_width_B].split.map {|r| Rational(r) }.inject(:+).to_f
    @rollformqa.flange_C = params[:qaform][:flange_C].split.map {|r| Rational(r) }.inject(:+).to_f
    @rollformqa.web_D = params[:qaform][:web_D].split.map {|r| Rational(r) }.inject(:+).to_f
    @rollformqa.flange_E = params[:qaform][:flange_E].split.map {|r| Rational(r) }.inject(:+).to_f
    if params[:qaform][:return_O] == nil
      @rollformqa.return_O == "0.00".to_f
    else 
      @rollformqa.return_O = params[:qaform][:return_O].split.map {|r| Rational(r) }.inject(:+).to_f
    end
    if params[:qaform][:return_D] == nil
      @rollformqa.return_D == "0.00".to_f
    else 
      @rollformqa.return_D = params[:qaform][:return_D].split.map {|r| Rational(r) }.inject(:+).to_f 
    end
    @rollformqa.actual_length = params[:qaform][:actual_length].split.map {|r| Rational(r) }.inject(:+).to_f
    @rollformqa.meets_visual = params[:qaform][:meets_visual]
    @rollformqa.thickness = params[:qaform][:thickness].split.map {|r| Rational(r) }.inject(:+).to_f
    @rollformqa.piececount = params[:qaform][:piececount].split.map {|r| Rational(r) }.inject(:+).to_i
    @rollformqa.user_notes = params[:qaform][:user_notes]
    @rollformqa.users_id = session[:user_id]
    @rollformqa.save
    if @rollformqa.save
     flash[:notice] = "QA Form submitted successfully!"
         redirect_to(:action => 'index', :trans_code => @trans_code)
    else
     flash[:notice] = "Oooops QA FORM NOT SUCCESSFULLY SUBMITTED!"
         redirect_to(:action => 'show', :newid => @newrollformqa.id, :itemnum => params[:member][:member_id], 
                                       :reqlength => @pwolinelength, :pmark => @pwolinepmark)
     end
end

 def update_profiles
   @profiles = PwoLines.where("pwo_headers_id = ?", params[:header_id]).group(:item_number).itmsorted
     respond_to do |format|
      format.js
    end
  end

  def update_piecemarks
    @pcemarks = PwoPieceMarks.where("item_number = ? AND pwo_headers_id = ?", params[:member_id], params[:header_id]).group(:piecemark).pmsorted
     respond_to do |format|
      format.js
    end
  end

private

def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'qa',
                                             :sub_module => 'roll_form_qa').first
      unless found_page_access
         flash[:notice] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems_login', :action => 'index.html')
      return false
      else return true
      end
  end

def profile_qa_params
   params.require(:rollformer_qa_checks).permit(:pwo_order_id, :item_number, :piecemark, :hole_center_width_A, :hole_center_width_B,
                                               :flange_C, :web_D, :flange_E, :return_O, :return_D, :actual_length, :meets_visual, :user_notes,
                                               :coilid, :header_id, :member_id, :pcemark_id, :requested_length, :item_number) 
end

end
