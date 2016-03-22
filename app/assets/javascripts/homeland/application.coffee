#= require jquery
#= require homeland/tether.min
#= require homeland/bootstrap.min
#= require homeland/jquery.timeago
#= require_self

window.Homeland =
  init: ->
    $("abbr.timeago").timeago()

$(document).ready ->
  Homeland.init()
