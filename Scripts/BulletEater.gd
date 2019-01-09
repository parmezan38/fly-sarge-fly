extends KinematicBody2D

const platform_scene = preload("res://Object_Scenes/PlatformBullet.tscn")
var is_eaten = true

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if is_eaten:
		eat_platform()
	pass

func eat_platform():
	pass
