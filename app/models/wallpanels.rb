class Wallpanels < ActiveRecord::Base
	
	has_many :wallpanel_tracking

    def updateddate
 	"#{WallpanelTracking.updated_at.to_s[0..9]}"
 end 

end
