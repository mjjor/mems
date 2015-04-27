class CalcFractionsController < ApplicationController

layout "mems_landing"

  def index
  	
  end

  def calcFract
  		@denom  = 16

  		@value1  = if params[:fractnum1].include? "-" 
  			       then (params[:fractnum1].gsub("-", "").split.map {|r| Rational(r) }.inject(:+).to_f) * -1 
  			       else  params[:fractnum1].split.map {|r| Rational(r) }.inject(:+).to_f
  			       end
  		@value2 = if params[:fractnum2].include? "-" 
  			       then (params[:fractnum2].gsub("-", "").split.map {|r| Rational(r) }.inject(:+).to_f) * -1 
  			       else  params[:fractnum2].split.map {|r| Rational(r) }.inject(:+).to_f
  			       end
  		@value3 = if params[:fractnum3].include? "-" 
  			       then (params[:fractnum3].gsub("-", "").split.map {|r| Rational(r) }.inject(:+).to_f) * -1 
  			       else  params[:fractnum3].split.map {|r| Rational(r) }.inject(:+).to_f
  			       end
  		@value4 = if params[:fractnum4].include? "-" 
  			       then (params[:fractnum4].gsub("-", "").split.map {|r| Rational(r) }.inject(:+).to_f) * -1 
  			       else  params[:fractnum4].split.map {|r| Rational(r) }.inject(:+).to_f
  			       end
  		@value5 = if params[:fractnum5].include? "-" 
  			       then (params[:fractnum5].gsub("-", "").split.map {|r| Rational(r) }.inject(:+).to_f) * -1 
  			       else  params[:fractnum5].split.map {|r| Rational(r) }.inject(:+).to_f
  			       end

   		@decval = @value1 + @value2 + @value3 + @value4 + @value5

  		@fractval = @decval - @decval.to_i

  		@intval = @decval.to_i

  		@numer = (@fractval * @denom).to_i

	  case @numer
		  when 15, -15 then @fract = " 15/16"
		  when 14, -14 then @fract = " 7/8"
		  when 13, -13 then @fract = " 13/16"
		  when 12, -12 then @fract = " 3/4"
		  when 11, -11 then @fract = " 11/16"	
		  when 10, -10 then @fract = " 5/8"	
		  when 9, -9 then @fract = " 9/16"	
		  when 8, -8 then @fract = " 1/2"
		  when 7, -7 then @fract = " 7/8"
		  when 6, -6 then @fract = " 3/8"
		  when 5, -5 then @fract = " 5/16"
		  when 4, -4 then @fract = " 1/4"
		  when 3, -3 then @fract = " 3/16"
		  when 2, -2 then @fract = " 1/8"
		  when 1, -1 then @fract = " 1/16"
		  else @fract = " "	
		  end

	  
	  @fractresult= @intval.to_s + @fract 

	  redirect_to(:action => 'show', :results => [params[:fractnum1], params[:fractnum2], params[:fractnum3], params[:fractnum4],
	  	                                          params[:fractnum5], @fractresult, @numer]) 
  end

  def show
    render('calc_fractions/show')
  end

end
