$(document).ready ->

  $('.add-subtype-button').on 'click', (e) ->
    e.preventDefault()
    $lastEmailField = $('.creature_subtypes:last-of-type').clone()
    $lastEmailField.find('input').val("")
    $("div#main .creature_subtypes_block").append($lastEmailField)

  $('#myTabs a').click (e) ->
    e.preventDefault()
    $(this).tab 'show'
    return

  return
