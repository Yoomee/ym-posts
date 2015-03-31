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
        $("body").on 'click', 'form.post_form:not(.expanded)',  () ->
          YmPosts.Form.showExpandedFields()
        $("body").on 'focusin', 'form.post_form:not(.expanded)', () ->
          YmPosts.Form.showExpandedFields()
        $('.post-add-media').on 'click', (event) ->
          event.preventDefault()
          parentForm = $(this).parents('form')
          parentForm.find(".post-media-field:not([data-media-type='#{$(this).data('media-type')}'])").hide()
          parentForm.find(".post-media-field[data-media-type='#{$(this).data('media-type')}']").toggle()
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
      $("body").on 'ajax:before', '.posts .pagination a', ->
        $('.posts').addClass('loading')

YmComments =
  Form:
    init: (options = {submitOnEnter: true}) ->
      $("body").on 'ajax:beforeSend', '.comment-form form', () ->
        $(this).addClass("loading")
      $(".comment-form textarea").autogrow()
      if options.submitOnEnter
        $("body").on 'keydown', ".comment-form textarea", (event) ->
          if event.keyCode == 13
            event.preventDefault()
            $(this).parents('form').submit()
      $("body").on 'click', '.comment-delete-link', (event) ->
        event.preventDefault()
window.YmComments = YmComments

$(document).ready ->
  YmPosts.init()
