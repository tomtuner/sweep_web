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
 $("#sweep-pass").hover (->
   $("#sweep-pass-pop").fadeIn(500)
   return
 ), ->
   $("#sweep-pass-pop").fadeOut(500)
   return
 unless ("ontouchstart" not of window) #check for touch device
   $("#sweep-pass").unbind "click mouseenter mouseleave hover" #use off if you used on, to unbind usual listeners
   $("#sweep-pass-pop").on "click", ->
    $("#sweep-pass-pop").fadeToggle(500)
   $("#sweep-pass").on "click", ->
    $("#sweep-pass-pop").fadeToggle(500)
    return