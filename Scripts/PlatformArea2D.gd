extends Area2D
# STEVEN
# S  T  E  V  E  N
export var platform_speed = 50
var velocity = Vector2()
var direction = 1

const WALL_LEFT_NORMAL = Vector2(1,0)
const WALL_RIGHT_NORMAL = Vector2(-1,0)

var is_stopped = false

func _ready():
	set_fixed_process(true)
	pass
func _fixed_process(delta):
	velocity.x = platform_speed * direction * delta
	if is_colliding():
		var colliding_body = get_collider()
		var normal = get_collision_normal()
		get_node("Label").set_text("colliding_body: " + str(colliding_body))
		if colliding_body.is_in_group("Player"):
			is_stopped = true
		
		if normal == WALL_LEFT_NORMAL and colliding_body.is_in_group("Walls"):
			direction = 1
		elif normal == WALL_RIGHT_NORMAL and colliding_body.is_in_group("Walls"):
			direction = -1
			
		
	
	if is_stopped:
		pass
	else:
		move(velocity)
	