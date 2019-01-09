extends KinematicBody2D
# STEVEN
# S  T  E  V  E  N
export var platform_speed = 50
var velocity = Vector2()
export var direction = 1

const WALL_LEFT_NORMAL = Vector2(1,0)
const WALL_RIGHT_NORMAL = Vector2(-1,0)

onready var animationPlayer = get_node("AnimationPlayerSteven")

var is_stopped = false
var is_unfreezing = false
var has_been_hit = false
var time_to_unfreeze = 0
const TIME_TO_UNFREEZE = 10
const TIME_TO_PLAYANIMATION = 8

var can_play_hit_animation = true
var can_play_unfreeze_animation = true

func _ready():
	animationPlayer.play("idle")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if is_stopped:
		if !is_unfreezing:
			freezing(delta)
	elif !is_stopped:
		moving(delta)
	if is_unfreezing:
		unfreezing(delta)

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
			is_unfreezing = true

func unfreezing(delta):
	velocity.x = 0
	time_to_unfreeze += delta
	if time_to_unfreeze > TIME_TO_PLAYANIMATION:
		if can_play_unfreeze_animation:
			print(time_to_unfreeze)
			animationPlayer.play("unfreeze")
			can_play_unfreeze_animation = false
			can_play_hit_animation = true
	if time_to_unfreeze >= TIME_TO_UNFREEZE:
		is_stopped = false
		time_to_unfreeze = 0
		is_unfreezing = false
	pass

func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player":
		is_stopped = true
		has_been_hit = true
	pass # replace with function body

func _on_Area2D_body_exit( body ):
	if body.get_name() == "Player":
		
		pass
	pass # replace with function body