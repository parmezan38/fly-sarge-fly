extends Node2D
var loader
var wait_frames
var time_max = 10000.0 # msec
var current_scene = null
var current_scene_deleted = false

onready var fadesAnimation = get_tree().get_root().get_node("Main/Fades/fades_animation_player")
onready var levelSpace = get_tree().get_root().get_node("Main/LevelSpace")
onready var root = get_tree().get_root() 
func _ready():
	var root_children = root.get_children()
	pass

func isponova_nodes():
	fadesAnimation = get_tree().get_root().get_node("Main/Fades/fades_animation_player")
	levelSpace = get_tree().get_root().get_node("Main/LevelSpace")
	root = get_tree().get_root()
	var root_children = root.get_children()
	pass

func goto_scene(path): # game requests to switch to this scene
	wait_frames = 120.0
	current_scene = levelSpace.get_child(0)
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # check for errors
		show_error()
		return
	set_process(true)
	# start your "loading..." animation
	fadesAnimation.play("ToBlackThenBlack")

func _process(time):
	if loader == null:
		# no need to process anymore
		set_process(false)
		return
	
	if wait_frames > 0.0: # wait for frames to let the "loading" animation to show up
		wait_frames -= 1.0
		return
	
	if wait_frames < 35.001:
		if current_scene != null:
			var wr = weakref(current_scene)
			if (!wr.get_ref() ):
				#object is erased
				pass
			else:
				wr.get_ref().queue_free()
		else:
			pass
	
	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max: # use "time_max" to control how much time we block this thread
	
		# poll your loader
		var err = loader.poll()
	
		if err == ERR_FILE_EOF: # load finished
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		elif err == OK:
			#update_progress()
			pass
		else: # error during loading
			show_error()
			loader = null
			break

func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	levelSpace.add_child(current_scene)