extends Node2D

onready var main = get_tree().get_root().get_node("Main")
onready var levelScript = get_parent()
onready var light2D = get_node("Light2D")
onready var lightSprite = get_node("LightSprite")
onready var version_01 = get_node("Version_01")
onready var version_02 = get_node("Version_02")
onready var version_03 = get_node("Version_03")
onready var version_04 = get_node("Version_04")

func _ready():
	if main.is_exit_open:
		light2D.show()
		lightSprite.show()
	else:
		light2D.hide()
		lightSprite.hide()
	# Background Sprite Version
	if levelScript.backgroundVersion == 1:
		version_01.show()
		version_02.hide()
		version_03.hide()
		version_04.hide()
	elif levelScript.backgroundVersion == 2:
		version_01.hide()
		version_02.show()
		version_03.hide()
		version_04.hide()
	elif levelScript.backgroundVersion == 3:
		version_01.hide()
		version_02.hide()
		version_03.show()
		version_04.hide()
	elif levelScript.backgroundVersion == 3:
		version_01.hide()
		version_02.hide()
		version_03.hide()
		version_04.show()
	
	if settingsGlobal.lights_on == true:
		light2D.show()
		lightSprite.hide()
	else:
		light2D.hide()
		lightSprite.show()
	pass
	
