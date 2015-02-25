class Modifyusersecurity < ActiveRecord::Migration
  def up
  	remove_column :user_securities, :security_groupid
  	remove_column :user_securities, :workstationid
  	add_column :user_securities, :module, :string
  	add_column :user_securities, :sub_module, :string
  	add_column :user_securities, :can_add, :boolean, :default => false
  	add_column :user_securities, :can_edit, :boolean, :default => false
  	add_column :user_securities, :can_delete, :boolean, :default => false
  end

  def down
  	add_column :user_securities, :security_groupid, :integer
  	add_column :user_securities, :workstationid, :integer
  	remove_column :user_securities, :module
  	remove_column :user_securities, :sub_module
  	remove_column :user_securities, :can_add
  	remove_column :user_securities, :can_edit
  	remove_column :user_securities, :can_delete
  end


end
