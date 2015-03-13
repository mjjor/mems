class CoilReceipts < ActiveRecord::Base

has_one :inv_cost_layers
has_one :inv_lot


end