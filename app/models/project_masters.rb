class ProjectMasters < ActiveRecord::Base

	has_many :pwo_headers
	has_many :phase_masters
	
end
