extends Button
var levelSpace
var levelList
var level
export var levelName = ""

func _ready():
	var levelSpace = get_parent().get_parent().get_parent().get_parent()
	levelSpace.levelList.end
		# Assignaj mu ime
	
	if levelName == "Intro":
		set_text("Intro")
	elif levelName == "End":
		if levelSpace.levelList.end.accessible:
			show()
			set_text("End")
		else:
			hide()
	else:
		#print("error at button")
		pass
	set_process(true)
	pass

func _process(delta):
	if is_pressed():
		if levelName == "Intro":
			backgroundLoadingShorter.goto_scene("res://Scenes/Intro.tscn")
		elif levelName == "End":
			backgroundLoadingShorter.goto_scene("res://Scenes/End.tscn")
		#backgroundLoadingShorter.goto_scene(level.location)
		
		var loadLevelsNode = get_parent().get_parent()
		var main_Menu = get_parent().get_parent().get_parent()
		loadLevelsNode.hide()
		main_Menu.show_menu_buttons = false
	pass
