class CreatePwoHeaders < ActiveRecord::Migration
  def change
    create_table :pwo_headers do |t|
    	t.integer :companyid
    	t.integer :warehouseid
    	t.integer :workstationid
        t.string :pwo_worderno
        t.integer :parent_pwoid
    	t.string :pwo_sales_orderid
    	t.integer :pwo_status
        t.string :pwo_export_key
    	t.integer :pwo_projectid
    	t.integer :pwo_phaseid
    	t.integer :pwo_project_itemid
    	t.date :date_released
    	t.date :date_scheduled
    	t.date :date_started
    	t.date :date_complete
        t.text :notes
        t.text :user_notes
        t.timestamps
    end
    add_index :pwo_headers, ["pwo_worderno", "companyid", "warehouseid"], {name: "worder"}
    add_index :pwo_headers, ["pwo_sales_orderid", "companyid", "warehouseid"], {name: "sales_order"}
    add_index :pwo_headers, ["pwo_export_key", "companyid", "warehouseid"], {name: "export_key"}
  end
end
