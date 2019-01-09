extends KinematicBody2D

const platform_scene = preload("res://Object_Scenes/PlatformBullet.tscn")
onready var kinematicBody = get_node("Kinematic")
onready var colBox = get_node("Kinematic/colBox")
onready var sprite = get_node("Sprite")
onready var animationPlayer = get_node("AnimationPlayer")
var is_shot = true
var is_eaten = false
var is_platform_alive = false
var launcher = get_owner()
var platform
var this_node = self
export var direction_to_right = true
var direction = 1
export var is_eater = false
var can_play_anim = true
export var platform_speed = 100

func _ready():
	if direction_to_right:
		sprite.set_flip_h(false)
		direction = 1
	else:
		sprite.set_flip_h(true)
		direction = -1
	if is_eater:
		add_to_group("BulletEater", true)
		kinematicBody.add_to_group("BulletEater", true)
		if direction_to_right:
			colBox.set_pos(Vector2(67,0) )
		else:
			colBox.set_pos(Vector2(-65,0) )
		colBox.set_trigger(false)
	else:
		colBox.set_trigger(true)
		pass
	set_fixed_process(true)

func _fixed_process(delta):
	if !is_eater:
		if is_shot:
			spit_platform()
		if is_platform_alive:
			if platform.is_eaten:
				if can_play_anim:
					animationPlayer.play("shake")
					can_play_anim = false
				platform.set_pos(Vector2(-12,0))
				
				platform.is_eaten = false
	pass

func spit_platform():
	print("stae")
	if can_play_anim:
		animationPlayer.play("shake")
		can_play_anim = false
	platform = platform_scene.instance()
	platform.set_pos(Vector2(-12,0))
	platform.platform_speed = platform_speed
	add_child(platform)
	platform.set_draw_behind_parent(true)
	is_shot = false
	is_platform_alive = true
	platform.direction = direction
	pass

func _on_AnimationPlayer_finished():
	can_play_anim = true
	pass # replace with function body
