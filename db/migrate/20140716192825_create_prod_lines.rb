class CreateProdLines < ActiveRecord::Migration
  def change
    create_table :prod_lines do |t|
    	t.string :company
    	t.string :prod_line_desc
    	t.string :prod_line_prefix 
    	t.boolean :is_active
      	t.timestamps
    end
  end
end
