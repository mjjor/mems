class CoilWidthController < ApplicationController
  
  layout "mems_landing"

  def widthNew

  end

  def widthCalc
  	@web    = params[:web].split.map {|r| Rational(r) }.inject(:+).to_f
    @leg    = params[:leg].split.map {|r| Rational(r) }.inject(:+).to_f
    @flange = params[:flange].split.map {|r| Rational(r) }.inject(:+).to_f

    
	@studCoilWidth = (@web.to_f - (2 * (0.09375 + params[:thickness].to_f)) +
  		2 * (@leg.to_f - 2 * (0.09375 + params[:thickness].to_f)) +
    	2 * (0.09375 + (params[:thickness].to_f / 3)) * Math::PI  +
    	2 * (@flange.to_f - (0.09375 + params[:thickness].to_f)))
    
    @trackCoilWidth = (@web.to_f - (2 * (0.09375 + params[:thickness].to_f)) +
   	  2 * (@leg.to_f - (0.09375 + params[:thickness].to_f)) +
     (0.09375 + (params[:thickness].to_f / 3)) * Math::PI) + (params[:thickness].to_f * 2)

		@studSqftPerFoot = ((@web.to_f - (2 * (0.09375 + params[:thickness].to_f)) +
   		2 * (@leg.to_f - 2 * (0.09375 + params[:thickness].to_f)) +
   		2 * (0.09375 + (params[:thickness].to_f / 3)) * Math::PI  +
   		2 * (@flange.to_f - (0.09375 + params[:thickness].to_f))) / 
   		12)

    @trackStftPerFoot = ((@web.to_f - (2 * (0.09375 + params[:thickness].to_f)) +
        2 * (@leg.to_f - (0.09375 + params[:thickness].to_f)) +
        (0.09375 + (params[:thickness].to_f / 3)) * Math::PI) / 
    	 12)

    @studSqftWeight = (((@web.to_f - (2 * (0.09375 + params[:thickness].to_f)) +
        2 * (@leg.to_f - 2 * (0.09375 + params[:thickness].to_f)) +
        2 * (0.09375 + (params[:thickness].to_f / 3)) * Math::PI  +
        2 * (@flange.to_f - (0.09375 + params[:thickness].to_f))) / 
      	12) *
    	 (params[:thickness].to_f / 0.0239))
    
    @trackSqftWeight = (((@web.to_f - (2 * (0.09375 + params[:thickness].to_f)) +
        2 * (@leg.to_f - (0.09375 + params[:thickness].to_f)) +
        (0.09375 + (params[:thickness].to_f / 3)) * Math::PI) / 
      	12) *
    	 (params[:thickness].to_f / 0.0239))
    
        
    case params[:thickness].to_f
      # when 0.0994..0.1174
      when 0.097..0.1174 
        then  @coilGauge = "12"
              @coilMils  = "97"
      # when 0.0705..0.0865 
      when 0.068..0.0865
        then  @coilGauge = "14"
              @coilMils  = "68"
      # when 0.0575..0.00695 
      when 0.054..0.0695  
        then  @coilGauge = "16"
              @coilMils  = "54"
      # when 0.0466..0.0566
      when 0.0430..0.0566 
        then  @coilGauge = "18"
              @coilMils  = "43"
      # when 0.0356..0.0436 
      when 0.0330..0.0436  
        then  @coilGauge = "20"
              @coilMils  = "33"
      # when 0.0326..0.0172
      when 00172..0.0326 
        then  @coilGauge = "25"
              @coilMils  = "18"
      else    @coilGauge = "N/A"
              @coilMils  = "N/A"    
    end    

    if (params[:flange].to_f == 0.0000)
        @studCoilWidth   = "0.00"
        @studSqftPerFoot = "0.00"
        @studSqftWeight  = "0.00"
    end
      
    redirect_to(:action => 'widthResult', :results => [params[:thickness], @web, @leg, @flange,
                                                      @studCoilWidth, @trackCoilWidth, @studSqftPerFoot, @trackStftPerFoot,
                                                      @studSqftWeight, @trackSqftWeight, @coilGauge, @coilMils])
  end

  def widthResult
  	 render('coil_width/widthResult')
  end
end
