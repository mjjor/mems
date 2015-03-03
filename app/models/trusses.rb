class Trusses < ActiveRecord::Base

	has_many :truss_trackings

	scope :lastupdate, lambda { order("trusses.updated_at DESC") } 
end
