# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	$('#flatstockCS').dataTable {
		"order": [[ 2 ]],
		"paging_type": "full_numbers -I"
	};
	sPaginationType: 'full_numbers'
	bJQueryUI: true

jQuery ->
	$('#viewCount').dataTable {
		"order": [[ 11, "desc" ]],
		"paging_type": "full_numbers -I"
	};
	sPaginationType: 'full_numbers'
	bJQueryUI: true

jQuery ->
	$(".best_in_place").best_in_place();	