extends KinematicBody2D
# PHAN
# P h A N
export var platform_speed = 50
var velocity = Vector2()
export var direction = -1

# Member variables
export var motion = Vector2()
export var cycle = 0.01
var accum = 0.0

func _ready():
	set_fixed_process(true)
	pass
func _fixed_process(delta):
	velocity.x = platform_speed * direction * delta
	move(velocity)
	if is_colliding():
		var colliding_body = get_collider()
		if colliding_body.is_in_group("ColForBounce"):
			direction *= -1
	
	get_node("Label").set_text("velocity.y: " + str(velocity.y))