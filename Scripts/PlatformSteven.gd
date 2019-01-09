extends KinematicBody2D
# STEVEN
# S  T  E  V  E  N
export var platform_speed = 50
var velocity = Vector2()
export var direction = 1

var is_sarge_on = false
var is_frozen = false
var can_play_hit_animation = true
var can_play_unfreeze_animation = true
const TIME_TO_UNFREEZE = 6
const TIME_TO_PLAYANIMATION = 4

const WALL_LEFT_NORMAL = Vector2(1,0)
const WALL_RIGHT_NORMAL = Vector2(-1,0)
var time = 0.0

onready var animationPlayer = get_node("AnimationPlayerSteven")

func _ready():
	animationPlayer.play("idle")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if is_sarge_on:
		is_frozen = true
		freezing(delta)
	else:
		if is_frozen:
			unfreezing(delta)
	if !is_frozen:
		moving(delta)

func moving(delta):
	velocity.x = platform_speed * direction * delta
	if is_colliding():
		var colliding_body = get_collider()
		var normal = get_collision_normal()
		if normal == WALL_LEFT_NORMAL and (colliding_body.is_in_group("Walls") or colliding_body.is_in_group("Platforms")):
			direction = 1
		elif normal == WALL_RIGHT_NORMAL and (colliding_body.is_in_group("Walls") or colliding_body.is_in_group("Platforms")):
			direction = -1
	move(velocity)
	pass

func freezing(delta):
	if can_play_hit_animation:
			animationPlayer.play("hit")
			can_play_hit_animation = false
			can_play_unfreeze_animation = true

func unfreezing(delta):
	velocity.x = 0
	time += delta
	if time > TIME_TO_PLAYANIMATION:
		if can_play_unfreeze_animation:
			animationPlayer.play("unfreeze")
			can_play_unfreeze_animation = false
			can_play_hit_animation = true
	if time >= TIME_TO_UNFREEZE:
		is_frozen = false
		time = 0
	pass

func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player":
		is_sarge_on = true
		time = 0
		pass

func _on_Area2D_body_exit( body ):
	if body.get_name() == "Player":
		is_sarge_on = false
		time = 0
		pass