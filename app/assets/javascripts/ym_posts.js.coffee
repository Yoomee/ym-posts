#= require jquery.remotipart

YmPosts =
  Pagination:
    init: () ->
      $('.posts .pagination a').live 'ajax:before', -> 
        $('.posts').addClass('loading')
        
$(document).ready ->
  YmPosts.Pagination.init()
