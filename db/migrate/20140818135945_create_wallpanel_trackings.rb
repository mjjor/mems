class CreateWallpanelTrackings < ActiveRecord::Migration
  def change
    create_table :wallpanel_trackings do |t|
      t.integer :wallpanels_id
      t.string  :trans_code
      t.integer :users_id
      t.timestamps
    end
    add_index :wallpanel_trackings, [:wallpanels_id], {name: "wallpanel_id"}
    add_index :wallpanel_trackings, [:wallpanels_id, :created_at], {name: "created"}
    add_index :wallpanel_trackings, [:wallpanels_id, :trans_code, :created_at], {name: "transcode"} 
  end
end
