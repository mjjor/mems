class CreateWorkstations < ActiveRecord::Migration
  def change
    create_table :workstations do |t|
    	t.string :company
    	t.string :workstation
    	t.integer :prod_lineid
    	t.decimal :prod_sequence
    	t.decimal :min_security
      	t.timestamps
    end
    add_index :workstations, [:workstation], {name: "workstation"}
    add_index :workstations, [:workstation, :prod_sequence], {name: "workstation_sequence"}
  end
end
