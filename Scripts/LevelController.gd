extends Node

var current_scene = null
var next_scene = null
var midLoadingScene = null
const loadingScene = preload("res://Scenes/MidSceneLoading.tscn")

func _ready():
	pass

func setFirstScene(scene):
	var s = ResourceLoader.load(scene)
	# Deleting current scene
	current_scene = s.instance()
	get_tree().get_root().get_node("Main/LevelSpace").add_child(current_scene)

func setScene(scene):
	print("get_children: " + str(get_tree().get_root().get_node("Main/LevelSpace").get_child(0)))
	current_scene = get_tree().get_root().get_node("Main/LevelSpace").get_child(0)
	print("get current_scene: " + str(current_scene))
	var s = ResourceLoader.load(scene)
	current_scene.queue_free()
	current_scene = s.instance()
	get_tree().get_root().get_node("Main/LevelSpace").add_child(current_scene)