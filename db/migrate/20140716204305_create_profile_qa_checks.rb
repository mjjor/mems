class CreateProfileQaChecks < ActiveRecord::Migration
  def change
    create_table :profile_qa_checks do |t|
    	t.integer :itemid
    	t.string :profile
    	t.string :coil_material
		t.integer :userid
		t.integer :workorderid
		t.integer :wo_lineid
		t.integer :workstationid
		t.integer :piececount
		t.string :piecemark
		t.string :coilid
		t.decimal :thickness
		t.decimal :required_length
		t.decimal :actual_length
		t.decimal :hole_center_width_A
		t.decimal :hole_center_width_B
		t.decimal :flange_C
		t.decimal :web_D
		t.decimal :flange_E
		t.decimal :return_F
		t.decimal :flare
		t.decimal :overbend
		t.decimal :crown
		t.decimal :camber
		t.decimal :bow
		t.decimal :twist
        t.boolean :meets_visual, :default => false
        t.boolean :in_spec, :default => true
        t.boolean :needs_manager_approval, :default => false
		t.text :user_notes
		t.text :notes
	 	t.timestamps
    end
    add_index :profile_qa_checks, [:workorderid], {name: "workorder"}
    add_index :profile_qa_checks, [:coilid], {name: "coil"}
    add_index :profile_qa_checks, [:profile], {name: "profile"}
    add_index :profile_qa_checks, [:coil_material], {name: "coil_material"}
    add_index :profile_qa_checks, [:workorderid, :itemid], {name: "workorder_item"}
  end
end