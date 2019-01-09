extends KinematicBody2D
# Bullet
# BUUU               lelelele T
var platform_speed = 0
export var is_eaten = false
export var direction = 0
var velocity = Vector2()
func _ready():
	set_fixed_process(true)
	pass
func _fixed_process(delta):
	velocity.x = platform_speed * direction * delta
	move(velocity)
	if is_colliding():
		var colliding_body = get_collider()
		var normal = get_collision_normal()
		if colliding_body.is_in_group("BulletEater"):
			is_eaten = true
		pass