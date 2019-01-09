extends KinematicBody2D
var velocity = Vector2(0,0)

export var is_visible = 1
onready var animationPlayer = get_node("AnimationPlayerVassili")

var can_play_diss_anim = true
var can_play_appr_anim = true

export var time = 0
const TIME_TO_DISSAPPEAR = 6
const TIME_TO_APPEAR = 12

func _ready():
	if is_visible == 1:
		animationPlayer.play("none")
	else:
		animationPlayer.play("invisible")
	set_fixed_process(true)

func _fixed_process(delta):
	time += delta
	
	if time >= TIME_TO_APPEAR:
		time = 0
		if can_play_appr_anim:
			animationPlayer.play_backwards("dissappearing")
			can_play_appr_anim = false
			can_play_diss_anim = true
	
	if time >= TIME_TO_DISSAPPEAR:
		if can_play_diss_anim:
			animationPlayer.play("dissappearing")
			can_play_diss_anim = false
			can_play_appr_anim = true
