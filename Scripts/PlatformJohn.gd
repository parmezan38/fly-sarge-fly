extends KinematicBody2D
# JOHN
export var platform_speed = 50
export var direction = 1
var velocity = Vector2()

const WALL_LEFT_NORMAL = Vector2(1,0)
const WALL_RIGHT_NORMAL = Vector2(-1,0)
func _ready():
	set_fixed_process(true)
	pass
func _fixed_process(delta):
	velocity.x = platform_speed * direction * delta
	move(velocity)
	if is_colliding():
		var colliding_body = get_collider()
		var normal = get_collision_normal()
		if normal == WALL_LEFT_NORMAL and colliding_body.is_in_group("Walls"):
			direction = 1
		elif normal == WALL_RIGHT_NORMAL and colliding_body.is_in_group("Walls"):
			direction = -1
		pass
