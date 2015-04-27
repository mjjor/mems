class WallpanelTracking < ActiveRecord::Base

#belongs_to :wallpanels
has_one :wallpanels
belongs_to :wallpanels

validates_presence_of :panellabel
validates_presence_of :wallpanels_id
 #validates_presece_of Wallpanels.where(:panellabel = params[:panellabel])
 scope :lastupdate, lambda { order("wallpanel_trackings.updated_at DESC") } 

 def updateddate
 	"#{updated_at.to_s[0..9]}"
 end 

 def addfractions
  @denom  = 16
  @decval = params[:fractnum1].split.map {|r| Rational(r) }.inject(:+).to_f 
  			+
  			params[:fractnum2].split.map {|r| Rational(r) }.inject(:+).to_f 
			  if params[:fractnum3] != nil
			  +	
			  params[:fractnum3].split.map {|r| Rational(r) }.inject(:+).to_f 
			  end
			  if params[:fractnum4] != nil
			  	+
			  params[:fractnum4].split.map {|r| Rational(r) }.inject(:+).to_f 
			  end
			  if params[:fractnum5] != nil
			  +
			  params[:fractnum5].split.map {|r| Rational(r) }.inject(:+).to_f 
			  end

  @fractval = @decval - @decval.to_i

  @intval = decval.to_i

  @numer = (@fractval * denom).to_i

  case @numer
	  when 15 then @fract = " 15/16"
	  when 14 then @fract = " 7/8"
	  when 13 then @fract = " 13/16"
	  when 12 then @fract = " 3/4"
	  when 11 then @fract = " 11/16"	
	  when 10 then @fract = " 5/8"
	  when 9 then @fract = " 9/16"	
	  when 8 then @fract = " 1/2"
	  when 7 then @fract = " 7/8"
	  when 6 then @fract = " 3/8"
	  when 5 then @fract = " 5/16"
	  when 4 then @fract = " 1/4"
	  when 3 then @fract = " 3/16"
	  when 2 then @fract = " 1/8"
	  when 1 then @fract = " 1/16"
	  else @fract = " "	
	  end

  
  @fractback = @intval.to_s + @fract 

 end

end
