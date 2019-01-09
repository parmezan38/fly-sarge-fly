extends Node2D
onready var videoPlayer = get_node("VideoPlayer")
export var videoName = "000"
export var videoOpacity = 1.0
func _ready():
	if videoName == "001":
		videoPlayer.set_stream(load("res://Videos/scena_01.ogv") )
	elif videoName == "002":
		videoPlayer.set_stream(load("res://Videos/scena_02.ogv") )
	elif videoName == "003":
		videoPlayer.set_stream(load("res://Videos/scena_03.ogv") )
	elif videoName == "004":
		videoPlayer.set_stream(load("res://Videos/scena_04.ogv") )
	elif videoName == "005":
		videoPlayer.set_stream(load("res://Videos/scena_05.ogv") )
	elif videoName == "006":
		videoPlayer.set_stream(load("res://Videos/scena_06.ogv") )
	elif videoName == "007":
		videoPlayer.set_stream(load("res://Videos/scena_07.ogv") )
	elif videoName == "008":
		videoPlayer.set_stream(load("res://Videos/scena_08.ogv") )
	elif videoName == "009":
		videoPlayer.set_stream(load("res://Videos/scena_09.ogv") )
	elif videoName == "010":
		videoPlayer.set_stream(load("res://Videos/scena_10.ogv") )
	videoPlayer.set_opacity(videoOpacity)
	videoPlayer.play()
	set_process(true)
	pass
func _process(delta):
	if !videoPlayer.is_playing():
		videoPlayer.play()
