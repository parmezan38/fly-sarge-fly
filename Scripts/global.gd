extends Node

var current_scene = null

func _ready():
	current_scene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1 )
	pass

func isponova_nodes():
	current_scene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1 )
	pass


func setScene(scene):
	var s = ResourceLoader.load(scene)
	current_scene.queue_free()
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)

func setFirstScene(scene):
	var s = ResourceLoader.load(scene)
	# Brisanje current_scene
	current_scene = s.instance()
	get_tree().get_root().get_node("Main/LevelSpace").add_child(current_scene)