class CoilLengthController < ApplicationController
  	layout "mems_landing"

    def lengthNew
  	end

	def lengthCalc
		
		@outerDiam = params[:outerDiamIn].split.map {|r| Rational(r) }.inject(:+).to_f
        @innerDiam = params[:innerDiamIn].split.map {|r| Rational(r) }.inject(:+).to_f
        @width     = params[:widthIn].split.map {|r| Rational(r) }.inject(:+).to_f
        
  		# calc the area of the coil in square inches
    	@area = Math::PI * ((@outerDiam.to_f**2) - (@innerDiam.to_f**2)) / 4
    
		# calc the length of the coil in inches using the area calc'd above
		@length = @area / params[:thickness].to_f
		    
		# convert the length to feet
		@feet = (@length.to_f / 12)
		    
		# calc the squarae footage from the length
		@sqfootage = (@feet.to_f) * (@width.to_f / 12)
		#(divided input by 12 to get feet

		# calc the weight of a sqft
		@weight = (40.8 * params[:thickness].to_f)
		    
		# calc thex total weight
		@totalWeight = @weight.to_f * @sqfootage.to_f

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
      	
      	else  @coilGauge = "N/A"
              @coilMils  = "N/A"    
    end    
		    
		redirect_to(:action => 'showResult', :results => [params[:thickness], @width , @innerDiam, @outerDiam, 
			                                                   @feet, @weight, @totalWeight, @sqfootage, @coilGauge, @coilMils])
  	end

  	def showResult
  		render('coil_length/lengthResult')
  	end
end
