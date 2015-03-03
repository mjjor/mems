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

end
