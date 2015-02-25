class CreateUserSecurities < ActiveRecord::Migration
  def change
    create_table :user_securities do |t|
    	t.string :company
    	t.integer :security_groupid
    	t.integer :workstationid
    	t.integer :userid
      t.timestamps
    end
    add_index :user_securities, [:security_groupid], {name: "workstation"}
  end
end
