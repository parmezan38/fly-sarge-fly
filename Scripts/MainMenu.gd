extends Node2D
onready var main = get_tree().get_root().get_node("Main")
onready var mainMenuButtons = get_node("MainMenuButtons")
onready var loadLevelsScene = get_node("LoadLevels")
onready var loadCutscenesScene = get_node("LoadCutscenes")
onready var settingsScene = get_node("Settings")
onready var quitScene = get_node("QuitScene")
onready var creditsScene = get_node("CreditsScene")
var show_menu_buttons = true

onready var mainScene = get_parent().get_parent()
var musicScene

func _ready():
	musicScene = mainScene.get_node("Muzika")
	main.playFadesAnimation("FromBlack")
	set_process(true)
	musicScene.mute = false
	pass

func _process(delta):
	if(Input.is_action_pressed("move_left")):
		backgroundLoadingShorter.goto_scene("res://Scenes/Level_039.tscn")
		pass
	
	if loadLevelsScene.is_visible() or loadCutscenesScene.is_visible() or quitScene.is_visible() or !show_menu_buttons or settingsScene.is_visible() or creditsScene.is_visible():
		mainMenuButtons.hide()
	else:
		mainMenuButtons.show()

# NEW button
func _on_New_pressed():
	backgroundLoadingShorter.goto_scene("res://Scenes/Intro.tscn")
	show_menu_buttons = false
	pass 

# QUIT button
func _on_Quit_pressed():
	quitScene.show()
func _on_QuitNo_pressed(): # NO
	quitScene.hide()
func _on_QuitYes_pressed(): # YES
	get_tree().quit()

# LOAD button
func _on_Load_Level_pressed():
	loadLevelsScene.show()
	pass # replace with function body
func _on_LoadBack_pressed():
	loadLevelsScene.hide()
	pass # replace with function body

# CUTSCENES button
func _on_Cutscenes_pressed():
	loadCutscenesScene.show()
	pass # replace with function body
func _on_LoadCutscenesBack_pressed():
	loadCutscenesScene.hide()
	pass # replace with function body

# SETTINGS
func _on_Settings_pressed():
	settingsScene.reload_values_from_file()
	settingsScene.show()
	pass # replace with function body
func _on_LoadSettingsBack_pressed():
	settingsScene.hide()
	pass # replace with function body

# CREDITS
func _on_Credits_pressed():
	creditsScene.show()
	pass # replace with function body
func _on_CreditsBack_pressed():
	creditsScene.hide()
	pass # replace with function body



