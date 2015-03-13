class InvCostLayers < ActiveRecord::Base

has_one :item_masters
has_one :coil_receipts

scope :active, lambda { where(:active => true) }

def self.to_csv(options = {})
	CSV.generate(options) do |csv|
		csv << column_names
		all.each do |invcost|
		csv << invcost.attributes.values_at(*column_names)
    	end
	end
end

end