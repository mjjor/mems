class CreatePwoLines < ActiveRecord::Migration
  def change
    create_table :pwo_lines do |t|
    	t.integer :companyid
    	t.integer :warehouseid
    	t.integer :pwo_headerid
    	t.integer :parent_pwo_lineid
    	t.integer :itemid
    	t.integer :orderlineid
    	t.integer :userid
        t.integer :pwo_line_status 
    	t.decimal :req_qty, :default => 0.00
    	t.decimal :actual_qty, :default => 0.00
    	t.boolean :is_lot, :default => false
    	t.boolean :is_serial, :default => false
    	t.text :notes
    	t.text :user_notes
    	t.timestamps
    end
    add_index :pwo_lines, ["pwo_headerid"], {name: "pwo_header"}
    add_index :pwo_lines, ["itemid", "pwo_line_status"], {name: "item_status"}
    add_index :pwo_lines, ["itemid"], {name: "itemid"}
    add_index :pwo_lines, ["parent_pwo_lineid"], {name: "parent_pwo_line"}
    add_index :pwo_lines, ["orderlineid"], {name: "orderlineid"}   
    end
end
