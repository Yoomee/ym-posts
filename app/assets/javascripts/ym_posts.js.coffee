#= require jquery.remotipart
#= require jquery.autogrow-textarea

YmPosts =
  init: () ->
    YmPosts.Form.init()  
    YmPosts.Pagination.init()    
  Form:
    init: () ->
      $('form.post_form:not(.expanded)').live 'focusin', () ->
        `$(this)`.addClass('expanded')
      $('a[data-toggle]').live 'click', (event) ->
        event.preventDefault()
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