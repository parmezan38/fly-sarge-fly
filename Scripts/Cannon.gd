extends KinematicBody2D
# pjuu pjuuu CCAAAANNNOOOONNN
export var ball_speed = 100
export var direction = 1
const ball_scene = preload("res://Object_Scenes/CannonBall.tscn")
onready var animationPlayer = get_node("AnimationPlayer")
onready var animationPlayer4Face = get_node("AnimationPlayer4Face")
onready var locToShoot = get_node("CannonZaAnim/LocToShoot")
onready var cannonZaAnim = get_node("CannonZaAnim")

var is_shot = true
var is_eaten = false
var is_ball_alive = false
var can_shoot = false
var launcher = get_owner()
var ball
var this_node = self
var timeToOut = 0
var time = 0.0
export var timeToShoot = 0.0

func _ready():
	animationPlayer.play("idle")
	animationPlayer4Face.play("idle")
	set_fixed_process(true)
	cannonZaAnim.set_scale( Vector2(direction,1) )
	
func _fixed_process(delta):
	if !is_ball_alive:
		time += delta
		if time >= timeToShoot:
			can_shoot = true
			time = 0
			pass
	if can_shoot:
		if is_shot:
			shoot_ball()
		if is_ball_alive:
			if ball.is_hit_wall:
				ball.set_pos(Vector2(5000,5000))
				timeout(delta)
				shoot_ball()

func shoot_ball():
	animationPlayer4Face.play("shot")
	ball = ball_scene.instance()
	ball.set_pos(locToShoot.get_pos())
	add_child(ball)
	ball.set_draw_behind_parent(true)
	ball.ball_speed = ball_speed
	is_shot = false
	is_ball_alive = true
	ball.direction = direction
	pass

func timeout(delta):
	timeToOut += delta
	if timeToOut > 1.5:
		ball.queue_free()
		timeToOut = 0