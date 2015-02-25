class CreateSecurityGroups < ActiveRecord::Migration
  def change
    create_table :security_groups do |t|
    	t.string :validcompanies
    	t.string :security_group_desc
    	t.decimal :security_level	
      	t.timestamps
    end
    add_index :security_groups, [:security_group_desc], {name: "sec_group"}
  end
end
