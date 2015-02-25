class InvLots < ActiveRecord::Base

has_one :item_masters
has_one :inv_cost_layers

scope :active, lambda { where(:is_active => true) }

end
