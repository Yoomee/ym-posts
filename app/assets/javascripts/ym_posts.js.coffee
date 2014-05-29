#= require jquery.remotipart

YmPosts =
  init: () ->
    YmPosts.Comments.init()
    YmPosts.Form.init()  
    YmPosts.Pagination.init()
  Comments:
    init: () ->
      $('a.toggle-comments').click (event) ->
        event.preventDefault()
        $(this).parent().toggleClass('expanded')
  Form:
    init: () ->
      if $('form.post_form:not(.expanded)').length
        $(document).mouseup (event) =>
          expandedForm = $('form.post_form.expanded')
          if !expandedForm.is(event.target) && !expandedForm.has(event.target).length
            YmPosts.Form.hideIfNotEnteredData()
        $('form.post_form:not(.expanded) li').live 'click', () ->
          YmPosts.Form.showExpandedFields()
        $('form.post_form:not(.expanded)').live 'focusin', () ->
          YmPosts.Form.showExpandedFields()
    showExpandedFields: () ->
      $('form.post_form:not(.expanded)').addClass('expanded')
      $('.not-expanded').addClass('in')
    hideIfNotEnteredData: () ->
      expandedForm = $('form.post_form.expanded')
      enteredData = false
      expandedForm.find("input[type='text'], input[type='file'], textarea").each ->
        if $(this).val() != ''
          enteredData = true
          return
      unless enteredData
        expandedForm.removeClass('expanded')
        $('.not-expanded').removeClass('in')
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
      $('.comment-delete-link').live 'click', (event) ->        
        event.preventDefault()      
window.YmComments = YmComments

$(document).ready ->
  YmPosts.init()
