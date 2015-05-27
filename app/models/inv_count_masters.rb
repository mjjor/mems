class InvCountMasters < ActiveRecord::Base

validates :coil_cycle, numericality: { less_than_or_equal_to: 3 }
	
validates :misc_cycle, numericality: { less_than_or_equal_to: 3 }
	
validates :sheetsteel_cycle, numericality: { less_than_or_equal_to: 3 }
 	
validates :sheathing_cycle, numericality: { less_than_or_equal_to: 3 }
	
validates :is_active, numericality: { less_than_or_equal_to: 1 }		 
	
end