class InvCostLayers < ActiveRecord::Base

has_one :item_masters

scope :active, lambda { where(:active => true) }

end