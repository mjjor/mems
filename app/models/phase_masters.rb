class PhaseMasters < ActiveRecord::Base

    belongs_to :project_masters
	has_many :pwo_headers
	has_many :phase_masters
	
end
