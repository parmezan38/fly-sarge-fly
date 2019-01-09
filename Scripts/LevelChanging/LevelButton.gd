extends Button
var levelSpace
var levelList
var level
export var levelName = ""

func _ready():
	levelSpace = get_parent().get_parent().get_parent().get_parent()
	levelList = levelSpace.levelList
	level = levelSpace.levelList[levelName]
	
	# Hide or not
	if level.accessible:
		show()
	else:
		hide()
	# Assignaj mu ime
	set_text("Level " + str(level.number)) 
	
	set_process(true)
	pass

func _process(delta):
	if is_pressed():
		backgroundLoadingShorter.goto_scene(level.location)
		var loadLevelsNode = get_parent().get_parent()
		var main_Menu = get_parent().get_parent().get_parent()
		loadLevelsNode.hide()
		main_Menu.show_menu_buttons = false
	pass
