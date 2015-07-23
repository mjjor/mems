# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	$('#scantrus').dataTable( {
		"order": [[ 7, "desc" ]],
		"paging_type": "full_numbers",
		"pageLength": 25
	});
	sPaginationType: 'full_numbers -I'
	bJQueryUI: true