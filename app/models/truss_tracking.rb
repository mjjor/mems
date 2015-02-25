class TrussTracking < ActiveRecord::Base

has_one :trusses

validates_presence_of :trusslabel
validates_presence_of :trusses_id

end