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
	
	if level.number == 003:
		set_text("Act 01") 
	elif level.number == 007:
		set_text("Act 02") 
	elif level.number == 011:
		set_text("Act 03") 
	elif level.number == 015:
		set_text("Act 04") 
	elif level.number == 019:
		set_text("Act 05") 
	elif level.number == 023:
		set_text("Act 06") 
	elif level.number == 027:
		set_text("Act 07") 
	elif level.number == 031:
		set_text("Act 08") 
	elif level.number == 034:
		set_text("Act 09") 
	elif level.number == 038:
		set_text("Act 10") 
		pass
	set_process(true)
	pass

func _process(delta):
	if is_pressed():
		if level.number == 003:
			backgroundLoadingShorter.goto_scene("res://Scenes/CinemaScene/Cinema_003.tscn")
		elif level.number == 007:
			backgroundLoadingShorter.goto_scene("res://Scenes/CinemaScene/Cinema_007.tscn")
		elif level.number == 011:
			backgroundLoadingShorter.goto_scene("res://Scenes/CinemaScene/Cinema_011.tscn")
		elif level.number == 015:
			backgroundLoadingShorter.goto_scene("res://Scenes/CinemaScene/Cinema_015.tscn")
		elif level.number == 019:
			backgroundLoadingShorter.goto_scene("res://Scenes/CinemaScene/Cinema_019.tscn")
		elif level.number == 023:
			backgroundLoadingShorter.goto_scene("res://Scenes/CinemaScene/Cinema_023.tscn")
		elif level.number == 027:
			backgroundLoadingShorter.goto_scene("res://Scenes/CinemaScene/Cinema_027.tscn")
		elif level.number == 031:
			backgroundLoadingShorter.goto_scene("res://Scenes/CinemaScene/Cinema_031.tscn")
		elif level.number == 034:
			backgroundLoadingShorter.goto_scene("res://Scenes/CinemaScene/Cinema_034.tscn")
		elif level.number == 038:
			backgroundLoadingShorter.goto_scene("res://Scenes/CinemaScene/Cinema_038.tscn")
			pass
		#backgroundLoadingShorter.goto_scene(level.location)
		
		var loadLevelsNode = get_parent().get_parent()
		var main_Menu = get_parent().get_parent().get_parent()
		loadLevelsNode.hide()
		main_Menu.show_menu_buttons = false
	pass
