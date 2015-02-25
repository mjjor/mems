class AddPanelIndexes < ActiveRecord::Migration
  def change
  	add_column :wallpanels, :is_active, :boolean, :default => true 
  	add_index :wallpanels, [:panellabel], {name: "panellabel"}
  	add_index :wallpanels, [:exportkey], {name: "exportkey"}
  	add_index :wallpanels, [:projectnumber], {name: "project"}
  	add_index :wallpanels, [:bundle_id], {name: "bundle"}
  	add_index :wallpanels, [:panelnumber, :bundle_id], {name: "panel_bundle"}
  	add_index :wallpanels, [:exportkey, :bundle_id], {name: "exportkey_bundle"} 
  end
end
