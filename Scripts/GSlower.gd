extends KinematicBody2D
#SLOWER
export var platform_speed = 50
export var direction = 1
onready var sprite = get_node("Sprite")
onready var animationPlayer = get_node("AnimationPlayer")
onready var facaAnim = get_node("faca_anim")

var velocity = Vector2()

const WALL_LEFT_NORMAL = Vector2(1,0)
const WALL_RIGHT_NORMAL = Vector2(-1,0)

onready var playerSpace = get_parent().get_parent().get_node("PlayerSpace")
var player

func _ready():
	animationPlayer.play("idle")
	facaAnim.play("faca")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	
	if !player:
		if playerSpace.get_child_count() > 0:
			player = playerSpace.get_child(0)
	
	velocity.x = platform_speed * direction * delta
	move(velocity)
	# Sprite stuff
	if direction == 1:
		sprite.set_flip_h(false)
	elif direction == -1:
		sprite.set_flip_h(true)
	
	if is_colliding():
		var colliding_body = get_collider()
		var normal = get_collision_normal()
		if normal == WALL_LEFT_NORMAL and colliding_body.is_in_group("Walls"):
			direction = 1
		elif normal == WALL_RIGHT_NORMAL and colliding_body.is_in_group("Walls"):
			direction = -1
		pass

func _on_AreaMagla_body_exit( body ):
	player.multiplier = 1
	pass # replace with function body
