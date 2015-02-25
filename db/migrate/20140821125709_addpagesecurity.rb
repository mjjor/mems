class Addpagesecurity < ActiveRecord::Migration
  def change
  	add_column :user_securities, :access_page, :string
  end
end
