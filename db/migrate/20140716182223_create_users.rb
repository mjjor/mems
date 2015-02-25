class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :validcompanies
    	t.string :firstname
    	t.string :lastname
    	t.string :workstation
    	t.string :jobtitle
    	t.string :username
    	t.string :password_digest
    	t.string :email
    	t.string :email2
        t.string :im_address
    	t.string :phone, :default => '5192721001', :limit => 10
        t.integer :phone_country_code 
    	t.integer :extension
    	t.integer :mobile
        t.integer :mobile_country_code
    	t.integer :substituteid
    	t.boolean :is_local, :default => true
        t.boolean :is_active, :default => true
      	t.timestamps
    end
    add_index :users, [:username], {name: "username"}
    add_index :users, [:firstname, :lastname], {name: "firstlast"}
    add_index :users, [:email], {name: "email"}
    add_index :users, [:phone], {name: "phone"}
  end
end
