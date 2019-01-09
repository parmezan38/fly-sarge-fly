extends Node2D
# MAIN
onready var fadesAnimation = get_node("Fades/fades_animation_player")
onready var levelSpace = get_node("LevelSpace")
onready var exitMenu = get_node("Exit")
var do_light = true
var current_scene = null
var is_paused = false
var wr
var is_prev_scene_room = false
var is_exit_open = true

func _ready():
	setFirstScene("res://Scenes/MainMenu.tscn")
	wr = weakref(current_scene)
	set_fixed_process(true)
	set_process_input(true)
	
	#Reload globals names
	globals.isponova_nodes()
	backgroundLoading.isponova_nodes()
	backgroundLoadingShorter.isponova_nodes()
	pass

func _fixed_process(delta):
	get_tree().set_pause(is_paused)

func playFadesAnimation(animationToPlay):
	fadesAnimation.play(animationToPlay)

func setScene(scene):
	current_scene = levelSpace.get_child(0)
	var s = ResourceLoader.load(scene)
	current_scene.queue_free()
	current_scene = s.instance()
	levelSpace.add_child(current_scene)

func setFirstScene(scene):
	var s = ResourceLoader.load(scene)
	current_scene = s.instance()
	levelSpace.add_child(current_scene)

func _on_fades_animation_player_finished():
	pass # replace with function body

# EXIT
func _on_ExitNo_pressed(): # NO
	exitMenu.hide()
	get_tree().set_pause(false)
func _on_ExitYes_pressed(): # YES
	get_tree().set_pause(false)
	exitMenu.hide()
	backgroundLoading.goto_scene("res://Scenes/MainMenu.tscn")
