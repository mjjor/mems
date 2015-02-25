class ItemMasters < ActiveRecord::Base
	
    has_many :item_company_details 
	has_many :inv_lots
	has_many :inv_balances
	has_many :inv_balance_details
	has_many :inv_cost_layers
      
end