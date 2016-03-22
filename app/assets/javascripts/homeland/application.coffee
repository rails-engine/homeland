#= require jquery
#= require homeland/tether.min
#= require homeland/bootstrap.min
#= require homeland/jquery.timeago
#= require_self

window.TopicView =
  init: ->
    $('[data-action=reply]').off 'click.homeland'
    $('[data-action=reply]').on 'click.homeland', @replyAction

  replyAction: (e) ->
    target = $(e.currentTarget)
    replyId = target.data('reply-id')
    replyPanel = $('#reply-panel')
    replyPanel.show()
    replyPanel.find('textarea').focus()
    replyPanel.find('input[name="reply[reply_to_id]"]').val(replyId)
    return false


window.Homeland =
  init: ->
    $("abbr.timeago").timeago()

    TopicView.init()

$(document).ready ->
  Homeland.init()
