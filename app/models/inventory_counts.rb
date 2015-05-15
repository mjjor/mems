class InventoryCounts < ActiveRecord::Base


scope :itemorder, lambda { order("inventory_counts.item_number") }
scope :itemdesc, lambda { order("inventory_counts.item_description") }
scope :updated, lambda {order("inventory_counts.updated_at DESC")}

end