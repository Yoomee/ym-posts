#= require jquery.remotipart

YmPosts =
  init: () ->
    YmPosts.Form.init()  
    YmPosts.Pagination.init()    
  Form:
    init: () ->
      $('form.post_form:not(.expanded)').live 'focusin', () ->
        `$(this)`.addClass('expanded')
  Pagination:
    init: () ->
      $('.posts .pagination a').live 'ajax:before', -> 
        $('.posts').addClass('loading')

$(document).ready ->
  YmPosts.init()