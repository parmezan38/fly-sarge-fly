extends KinematicBody2D
onready var sarge_anim_player = get_node("sarge_anim_player")
onready var krila_anim_player = get_node("Krila/krila_anim_player")
onready var stomp_anim_player = get_node("stomp_anim_player")
onready var run_anim_player = get_node("run_anim_player")
onready var wing_dust_anim_player = get_node("wing_dust_anim_player")
onready var sprite_node = get_node("Sprite")
onready var runDustSprite = get_node("RunDust")
onready var kriloL = get_node("Krila/KriloL")
onready var kriloR = get_node("Krila/KriloR")
onready var rayGround = get_node("RayNode/RayGround")
onready var rayHelp1 = get_node("RayNode/RayHelp1")
onready var rayHelp2 = get_node("RayNode/RayHelp2")
onready var light2D = get_node("Light2D")
onready var lightSprite = get_node("LightSprite")
onready var collision = get_node("CollisionPolygon2D")
onready var colArea = get_node("AreaAll/CollisionPolygon2D1")
onready var samplePlayer = get_node("SamplePlayer")
onready var endArea = get_parent().get_parent().get_node("EndArea")
onready var main = get_parent().get_parent()

var State = preload("res://Scripts/Player/State.gd")
var IdleState = preload("res://Scripts/Player/IdleState.gd")
var idleState = IdleState.new()
var JumpingState = preload("res://Scripts/Player/JumpingState.gd")
var jumpingState = JumpingState.new()
var FallingState = preload("res://Scripts/Player/FallingState.gd")
var fallingState = FallingState.new()
var RunningState = preload("res://Scripts/Player/RunningState.gd")
var runningState = RunningState.new()
var state_ = null
var previous_state_ = null

export var StartingState = ""

var is_on_floor = false
var is_in_air
var is_jump_button = false
var is_on_kid = false
var platform_name = "none"

var is_paused = false

var speed = Vector2()
var velocity = Vector2()
var input_direction = 0
var direction_before_jump = 0
var direction = 1

var jump_count = 1
const MAX_JUMP_COUNT = 5
const GRAVITY = 1200
const FLOOR_NORMAL = Vector2(0,-1)
const FLOOR_ANGLE_TOLERANCE = 40
const SLOPE_FRICTION = 10

var get_platform = false
var is_on_cannonball = false
var is_on_vert_plat = false
var last_platform
var last_platform_velocity = Vector2()

var onair_time = 0
var self_rotation
export var next_rotation = 0.0
var new_rotation = 0

var multiplier = 1
var reverser = 1
var returning_to_ori_rot = false
var ray_hit = false
var start_rotating_back = false

func _ready():
	is_paused = false
	state_ = State.new()
	state_.enter(self)
	state_.getName()
	set_fixed_process(true)
	set_process(true)
	set_process_input(true)
	if StartingState != "":
		StartingState = load(StartingState)
		var startingState = StartingState.new()
		set_new_state(startingState)
	else:
		set_new_state(idleState)
	
	if settingsGlobal.lights_on == true:
		light2D.show()
		lightSprite.hide()
	else:
		light2D.hide()
		lightSprite.show()

func _input(event):
	state_.input(event)
	if event.is_action_pressed("jump"):
		is_jump_button = true
		if jump_count <= 1:
			samplePlayer.play("flap01",false)
		elif jump_count == 2:
			samplePlayer.play("flap02",false)
		elif jump_count == 3:
			samplePlayer.play("flap03",false)
		elif jump_count == 4:
			samplePlayer.play("flap04",false)
	else:
		is_jump_button = false
	pass

func _fixed_process(delta):
	get_node("Label").set_text(str(jump_count) )
	if is_on_cannonball:
		velocity.x = 0
	# kalkulacije za Is On Floor
	is_on_floor = is_move_and_slide_on_floor()
	var collision_normal = Vector2()
	if is_colliding():
		collision_normal = get_collision_normal()
	else:
		collision_normal = Vector2(0,0)
	if collision_normal == Vector2(0,-1):  # Is Hit Floor
		is_on_floor = true
	
	if rayGround.is_colliding():
		rayGround.force_raycast_update()
		if (rayGround.get_collider().get_name() == "PlatVassili"):
			if (rayGround.get_collider().is_visible == 0):
					is_on_floor = false
			else:
					is_on_floor = true
		else:
			is_on_floor = true
	if rayHelp1.is_colliding():
		rayHelp1.force_raycast_update()
		if (rayHelp1.get_collider().get_name() == "PlatVassili"):
			if (rayHelp1.get_collider().is_visible == 0):
					is_on_floor = false
			else:
					is_on_floor = true
		else:
			is_on_floor = true
	if rayHelp2.is_colliding():
		rayHelp2.force_raycast_update()
		if (rayHelp2.get_collider().get_name() == "PlatVassili"):
			if (rayHelp2.get_collider().is_visible == 0):
					is_on_floor = false
			else:
					is_on_floor = true
		else:
			is_on_floor = true
	
	if rayGround.is_colliding() or rayHelp1.is_colliding() or rayHelp2.is_colliding():
		ray_hit = true
	else:
		ray_hit = false
	
	if is_on_floor:
		#jump_count = 1
		pass
	
	# Get Platform
	if get_platform and last_platform and last_platform.get_type() != "StaticBody" and !is_on_cannonball:
		if last_platform:
			last_platform_velocity = last_platform.velocity
	else:
		last_platform_velocity = Vector2(0,0)
	# MORAM PROMINIT DA BUDE KA STARA VERZIJA AL DA KAD SE PROMINI DIRECTION DA SVEJEDNO IDE U TAJ DIRECTION
	# Is Jump Button
	if is_jump_button:
		direction_before_jump = input_direction
	# Direction Air And Ground
	if input_direction and not is_in_air:
		direction = input_direction
		direction_before_jump = input_direction
	elif input_direction and is_in_air:
		direction = input_direction
	
	if is_in_air and direction_before_jump != 0:
		if input_direction:
			direction = input_direction
		else:
			direction = direction_before_jump
	elif is_in_air and direction_before_jump == 0:
		if input_direction:
			direction = input_direction
		else:
			direction = input_direction
			direction_before_jump = input_direction
		pass
	
	self_rotation = get_rot()
	
	#Input
	if Input.is_action_pressed("move_left"):
			input_direction = -1 * reverser
	elif Input.is_action_pressed("move_right"):
			input_direction = 1  * reverser
	else:
		input_direction = 0
	
	if input_direction == - direction and is_in_air:
		speed.x /= 1.5
	elif input_direction == - direction:
		speed.x /= 5.0
	
	if is_paused:
		pass
	else:
		velocity = move_and_slide(velocity, FLOOR_NORMAL, SLOPE_FRICTION)
	state_.update(delta)
	
	new_rotation = lerp(self_rotation, next_rotation, 0.6 )
	
	if !is_paused:
		set_rot(new_rotation)
	if start_rotating_back:
		return_to_origin_rot_new(delta)
	# END FIXED PROCESS

func _process(delta):
	state_.handleAnimation()
	if sprite_node.is_flipped_h():
		collision.set_scale( Vector2(-1,1) )
		colArea.set_scale( Vector2(-1,1) )
	else:
		collision.set_scale( Vector2(1,1) )
		colArea.set_scale( Vector2(1,1) )
	
	#var distance2Hero = enemy.get_global_pos().distance_to(hero.get_global_pos()); 
	if main.is_kino == false:
		if endArea:
			var distance2EndArea = self.get_global_pos().distance_to(endArea.get_global_pos());  
			var volume = (distance2EndArea / - 10) + 40
			var levelSounds = get_parent().get_parent().get_node("LevelSounds")
			if volume > 10:
				volume = 10
			levelSounds.get_node("StreamPlayer").set_volume_db(volume)
	# END PROCESS

func set_new_state(new_state):
	previous_state_ = state_
	state_.exit()
	state_ = new_state
	state_.enter(self)
	#print("state_ : " + str(state_.getName()) + "  previous_state_ : " + str(previous_state_.getName()))
	pass

func return_to_origin_rot_new(delta):
	var rotation_velocity = 0
	var ROTATION_ACC = 0.08
	rotation_velocity = self_rotation + ROTATION_ACC * delta
	rotation_velocity = lerp(rotation_velocity, 0, 0.18)
	if self_rotation <= 0.01 and self_rotation >= -0.02:
		set_rot(0)
	else:
		set_rot(rotation_velocity)

# Down Enter
func _on_AreaDown_body_enter( body ):
	if body.is_in_group("Platforms"):
		get_platform = true
		last_platform = body
	elif body.is_in_group("CannonBall"):
		get_platform = true
		platform_name = "CannonBall"
		pass
	else:
		get_platform = false
	jump_count = 1
	pass
# Down Exit
func _on_AreaDown_body_exit( body ):
	platform_name = "none"
	pass 
# All Enter
func _on_AreaAll_body_enter( body ):
	start_rotating_back = true
	if body.is_in_group("CannonBall"):
		is_on_cannonball = true
	pass

# All Exit
func _on_AreaAll_body_exit( body ):
	is_on_cannonball = false
	#start_rotating_back = false
	pass

func _on_AreaForPlatVersions_body_enter( body ):
	if body.is_in_group("PlatformKid"):
		platform_name = "Kid"
		is_on_kid = true
	elif body.is_in_group("CannonBall"):
		platform_name = "CannonBall"
	elif body.is_in_group("PlatformJohn"):
		platform_name = "John"
	else:
		platform_name = "none"
	pass # replace with function body

func _on_AreaForPlatVersions_body_exit( body ):
	is_on_kid = false
	pass # replace with function body

func play_thump():
	var velocityToDb = velocity.y / 1000
	var thump = get_node("Thump")
	var sample = thump.play("thump",false)
	thump.set_volume(sample,(velocityToDb + 0.1) )
	pass