class CreateProductionSummaries < ActiveRecord::Migration
  def change
    create_table :production_summaries do |t|
    	t.integer :companies_id
        t.date :proddate
    	t.string :trans_code
    	t.string :workstation
    	t.decimal :units
    	t.decimal :unitcount
    	t.string :uom
    	t.string :category
    	t.timestamps
    end
    add_index :production_summaries, [:companies_id, :trans_code], {name: 'company_trans_code'}
    add_index :production_summaries, [:trans_code], {name: 'trans_code'}
    add_index :production_summaries, [:companies_id, :workstation], {name: 'company_workstation'}
    add_index :production_summaries, [:companies_id, :trans_code, :created_at], {name: 'company_trans_code_date'}
  end
end
