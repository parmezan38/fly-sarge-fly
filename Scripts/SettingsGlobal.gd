extends Node

var lights_on = false
var set_window_maximized_bool = true

func _ready():
	OS.set_window_maximized(set_window_maximized_bool)
	pass
