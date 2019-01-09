extends Node2D
onready var videoPlayer = get_node("VideoPlayer")
var time = 0.0
var video_is_finished = false
var done = false
var levelSpace
onready var mainScene = get_parent().get_parent()
var musicScene
func _ready():
	musicScene = mainScene.get_node("Muzika")
	set_process(true)
	video_is_finished = false
	videoPlayer.play()
	
	levelSpace = get_parent()
	levelSpace.levelList.end.accessible = true
	levelSpace.save_first_time()
	
	musicScene.mute = true
	pass

func _process(delta):
	time += delta
	if !video_is_finished:
		if !videoPlayer.is_playing():
			video_is_finished = true
	if video_is_finished and !done:
		#print("finito")
		new_scene()
	pass
	

func new_scene():
	var wr = weakref(videoPlayer)
	if (!wr.get_ref() ):
		#object is erased
		pass
	else:
		wr.get_ref().queue_free()
		backgroundLoading.goto_scene("res://Scenes/MainMenu.tscn")
		done = true
	
