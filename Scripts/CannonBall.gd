extends KinematicBody2D
# Cannon Ball

# CAAAAANOOOOONNNNN        BAAAALLLLLLLL
export var ball_speed = 150
export var is_hit_wall = false
export var direction = 0
var velocity = Vector2()
onready var sprite = get_node("Sprite")
var rotation = 0

func _ready():
	set_fixed_process(true)
	set_process(true)
	pass

func _process(delta):
	rotation -= 0.09
	sprite.set_rot(rotation)

func _fixed_process(delta):
	velocity.x = ball_speed * direction * delta
	move(velocity)
	if is_colliding():
		var colliding_body = get_collider()
		var normal = get_collision_normal()
		if colliding_body.is_in_group("Walls"):
			is_hit_wall = true
		pass
	get_node("Label").set_text("parent: " + str(get_parent().get_name()) + "velocity.x: " + str(velocity.x))