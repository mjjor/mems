# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	$('#itemledgers').dataTable( {
		"order": [[ 6, "desc" ]],
		"paging_type": "full_numbers -I"
	});
	sPaginationType: 'full_numbers'
	bJQueryUI: true