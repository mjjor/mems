() -> $(document).foundation('reflow')

$ ->
  $(document).on 'change', '#headers_select', (evt) ->
    $.ajax 'rollformer_qa_check/update_profiles',
      type: 'GET'
      dataType: 'script'
      data: {
        header_id: $("#headers_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic header select OK!")

$ ->
  $(document).on 'click', '#profiles_select', (evt) ->
    $.ajax 'rollformer_qa_check/update_piecemarks',
      type: 'GET'
      dataType: 'script'
      data: {
        header_id: $("#headers_select option:selected").val()
        member_id: $("#profiles_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic header select OK!")

$ ->
  $(document).SPServices.SPComplexToSimpleDropdown({
    columnName: "",
    completefunc: null,
    debug: true
    });