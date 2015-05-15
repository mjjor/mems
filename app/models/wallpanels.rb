class Wallpanels < ActiveRecord::Base
	
	has_many :wallpanel_tracking

	scope :lastupdate, lambda { order("wallpanels.updated_at DESC") } 
	scope :oldestupdate, lambda { order("wallpanels.updated_at") }

    def updateddate
 	"#{WallpanelTracking.updated_at.to_s[0..9]}"
 end 

end
