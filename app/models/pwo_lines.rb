class PwoLines < ActiveRecord::Base
 
belongs_to :pwo_headers

# acts_as_list :scope => :item
# acts_as_list :scope => :piece_mark

scope :itmsorted, lambda { order("pwo_lines.item_number") } 
scope :pmsorted, lambda { order("pwo_lines.piecemark") }

end
