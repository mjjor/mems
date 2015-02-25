class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
    	t.string :company_name
    	t.string :short_name
    	t.string :street_address1
    	t.string :street_address2
    	t.string :street_address3
    	t.string :street_city
    	t.string :street_prov
        t.string :street_pcode
        t.string :street_country
    	t.string :mail_address1
    	t.string :mail_address2
    	t.string :mail_address3
    	t.string :mail_city
    	t.string :mail_prov
    	t.string :mail_pcode
    	t.string :mail_country
    	t.string :phone
    	t.string :fax
    	t.string :email
    	t.string :local_currency
    	t.string :fed_tax_id
    	t.string :prov_tax_id
    	t.string :county_tax_id
    	t.string :city_tax_id
    	t.string :other_tax_id
    	t.string :duns_number
    	t.string :logo_file
    	t.string :clr_wip_acct
    	t.string :clr_payroll_acct
    	t.string :clr_equip_acct
    	t.string :clr_inv_acct
    	t.string :clr_poaccr_acct
    	t.string :clr_retainage_acct
    	t.string :clr_retainearn_acct
    	t.string :clr_exch_gainloss_acct
    	t.string :clr_sales_tax_acct
    	t.string :ar_acct
    	t.string :ar_discount_acct
    	t.string :ar_adjustment_acct
    	t.string :ar_holdback_acct
    	t.string :sales_taxrecd_acct
    	t.string :ar_def_bankacct
    	t.string :ap_acct
    	t.string :ap_discount_account
    	t.string :ap_adjustment_acct
    	t.string :sales_taxpaid_acct
    	t.string :purchase_variance_acct
    	t.string :ap_holdback_acct
    	t.string :ap_def_bankacct
    	t.string :inv_stock_acct
    	t.string :inv_nonstock_acct
    	t.string :inv_return_loss_acct
    	t.string :inv_xfer_acct
    	t.timestamps
    end
    add_index :companies, ["company_name"], {name: 'company'}
    add_index :companies, ["short_name"], {name: 'short_name'}
    add_index :companies, ["street_address1"], {name: 'streetaddress'}
    add_index :companies, ["street_city"], {name: 'city'}
    add_index :companies, ["street_prov"], {name: 'prov'}
    add_index :companies, ["street_prov", "street_city"], {name: 'prov_city'}
    add_index :companies, ["phone"], {name: 'phone'}
    add_index :companies, ["duns_number"], {name: 'duns'}
  end
end
