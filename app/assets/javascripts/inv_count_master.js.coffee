# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	$('#countadmin').dataTable {
		"order": [[ 6, "desc" ]],
		"paging_type": "full_numbers -I",
		"responsive": "true"
	};
	sPaginationType: 'full_numbers'
	bJQueryUI: true

jQuery ->
	$(".best_in_place").best_in_place();	