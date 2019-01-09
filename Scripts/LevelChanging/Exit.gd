extends Control
var current_scene = null
var levelSpace
onready var main = get_parent()
var wr
func _ready():
	#print(main.get_name() )
	levelSpace = main.get_node("LevelSpace")
	set_process_input(true)
	pass

func _input(event):
	if event.is_action_pressed("exit"):
		current_scene = levelSpace.get_child(0)
		wr = weakref(current_scene)
		if (wr.get_ref()):
			if current_scene.get_name() != "Main_Menu":
				if is_visible():
					hide()
					get_tree().set_pause(false)
				elif !is_visible():
					show()
					get_tree().set_pause(true)
		pass
