class InvLots < ActiveRecord::Base

has_one :item_masters
has_one :inv_cost_layers
has_one :coil_receipts

scope :active, lambda { where(:is_active => true) }

def self.to_csv(options = {})
	CSV.generate(options) do |csv|
		csv << column_names
		all.each do |invlot|
		csv << invlot.attributes.values_at(*column_names)
    	end
	end
end

end
