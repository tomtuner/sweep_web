# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$("#event_starts_at").datepicker()
	$("#event-id").toggle()
	$("#event-name").click( ->
	    $("#event-id").toggle()
	    $("#event-name").toggle()
	    return
	)
	$("#event-id").click( ->
	    $("#event-id").toggle()
	    $("#event-name").toggle()
	    return
	)
	return
	