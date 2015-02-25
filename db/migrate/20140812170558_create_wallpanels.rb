class CreateWallpanels < ActiveRecord::Migration
  def change
    create_table :wallpanels do |t|
    	t.string :panelnumber
    	t.string :panellabel
    	t.string :exportkey
    	t.string :projectnumber
    	t.string :exposure
    	t.decimal :length
    	t.decimal :height
    	t.decimal :areagross
    	t.decimal :areanet
    	t.boolean :is_loadbearing
    	t.boolean :is_sheathed
    	t.decimal :weight
    	t.decimal :weight_sheathed
    	t.integer :prod_sequence
    	t.string :bundle_id
    	t.string :bundle_position
    	t.integer :bundle_sequence 
    	t.string :updated_by
        t.boolean :is_active, :default => true 
    	t.timestamps
    end
  end
end
