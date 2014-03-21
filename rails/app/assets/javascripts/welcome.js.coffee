# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
 $(".qrcode-bg").toggle()
 $("#id-toggle").toggle()
 $("#show-id-toggle").toggle()
 $(".qrcode-bg").fadeToggle(1000)
 $("#show-id-toggle").fadeToggle(1000)
 
 
 $("#show-id-toggle").click( ->
  $("#show-id-toggle").toggle()
  $("#id-toggle").toggle()
  return
  )
 $("#id-toggle").click( ->
  $("#show-id-toggle").toggle()
  $("#id-toggle").toggle()
  return
  )