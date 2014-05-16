# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  request_article()
  $('#markdown').keyup -> request_article()
  $('#full_btn').click ->
    $('#full_btn').css('display', 'none')
    $('#half_btn').css('display', 'auto')
    $('#markdown-container').css('display', 'none')
    $('#preview-container').attr('class', 'col-xs-12')
  $('#half_btn').click ->
    $('#full_btn').css('display', 'auto')
    $('#half_btn').css('display', 'none')
    $('#markdown-container').css('display', 'auto')
    $('#preview-container').attr('class', 'col-xs-6')

request_article = ->
  $.ajax
    async:     true
    type:      "POST"
    url:       "/article/"+$('#provider').val()
    data:      {markdown : $('#markdown').val()}
    dataType:  "html"
    context:    this
    success:   (data, status, xhr) ->
      $('#preview').html(data)
      $('#preview pre').addClass('prettyprint')
      if $('#preview pre').attr('lang')?
        $('#preview pre').addClass('lang-'+ $('#preview pre').attr('lang'))
      prettyPrint()
      $('#markdown').height($('#preview').height())
