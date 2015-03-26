class PwoHeaders < ActiveRecord::Base

	# acts_as_list :scope => :pwo_worderno

    has_many :pwo_lines
    belongs_to :project_masters
    belongs_to :phase_masters

    scope :open, lambda { where(:status => [1,2]) }
	scope :updated, lambda { order("pwo_headers.updated_at DESC") }
	scope :wosorted, lambda { order("pwo_headers.pwo_worderno") }
end