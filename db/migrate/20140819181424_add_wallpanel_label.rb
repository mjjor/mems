class AddWallpanelLabel < ActiveRecord::Migration
  def change
  	add_column :wallpanel_trackings, :panellabel, :string
  end
end
