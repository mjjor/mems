class InvBalances < ActiveRecord::Base

belongs_to :item_masters 
belongs_to :item_company_details
# belongs_to :item_masters

scope :itmorder, lambda { order("inv_balances.item_masters_id") } 

def self.to_csv(options = {})
	CSV.generate(options) do |csv|
		csv << column_names
		all.each do |invbal|
		csv << invbal.attributes.values_at(*column_names)
    end
end
end

end