#= require jquery.remotipart

YmPosts =
  init: () ->
    YmPosts.Form.init()  
    YmPosts.Pagination.init()
  Form:
    init: () ->
      $(document).mouseup (event) =>
        expandedForm = $('form.post_form.expanded')
        if !expandedForm.is(event.target) && !expandedForm.has(event.target).length
          YmPosts.Form.hideIfNotEnteredData()
      $('form.post_form:not(.expanded)').live 'focusin', () ->
        $(this).addClass('expanded')
      $('.post-add-media').live 'click', (event) ->
        event.preventDefault()
        parentForm = $(this).parents('form')
        parentForm.find(".post-media-field:not([data-media-type='#{$(this).data('media-type')}'])").hide()
        parentForm.find(".post-media-field[data-media-type='#{$(this).data('media-type')}']").toggle()
    hideIfNotEnteredData: () ->
      expandedForm = $('form.post_form.expanded')
      enteredData = false
      expandedForm.find("input[type='text'], input[type='file'], textarea").each ->
        if $(this).val() != ''
          enteredData = true
          return
      unless enteredData
        expandedForm.removeClass('expanded')        
  Pagination:
    init: () ->
      $('.posts .pagination a').live 'ajax:before', -> 
        $('.posts').addClass('loading')

YmComments = 
  Form:
    init: (options = {submitOnEnter: true}) ->
      $('.comment-form form').live 'ajax:beforeSend', () ->
        $(this).addClass("loading")
      $(".comment-form textarea").autogrow()
      if options.submitOnEnter
        $(".comment-form textarea").live 'keydown', (event) ->
          if event.keyCode == 13
            event.preventDefault()
            $(this).parents('form').submit()
            
window.YmComments = YmComments

$(document).ready ->
  YmPosts.init()