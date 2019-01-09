extends "res://Scripts/Player/State.gd"
# JUUUUMPing state
var time_for_velocity = 1
func getName():
	return "Jumping Jump Jump Jump"

func enter(player):
	self.player = player
	#player.sprite_node.set_modulate("00FFFF") 
	player.speed.y = (- STARTING_JUMP_FORCE + (JUMP_FORCE_DECAY * player.jump_count)) * 1.75 * player.multiplier 
	player.sarge_anim_player.play("jump")
	player.run_anim_player.play("none")
	player.is_in_air = true
	player.start_rotating_back = false
	time_for_velocity = 1
	# Jump Animation
	if player.jump_count == 1:
		player.krila_anim_player.play("flap_1")
		player.wing_dust_anim_player.play("flap_1")
	elif player.jump_count == 2:
		player.krila_anim_player.play("flap_2")
		player.wing_dust_anim_player.play("flap_2")
	elif player.jump_count == 3:
		player.krila_anim_player.play("flap_3")
		player.wing_dust_anim_player.play("flap_3")
	elif player.jump_count == 4:
		player.krila_anim_player.play("flap_4")
		player.wing_dust_anim_player.play("flap_4")
	else:
		player.krila_anim_player.play("krilo_null")
	pass

func update(_delta):
	delta = _delta
	time_for_velocity -= delta
	# Vertical movement
	player.speed.y += GRAVITY * delta  * player.multiplier 
	player.velocity.y = player.speed.y
	
	# Horizontal movement
	if player.input_direction:
		player.speed.x += (AIR_ACCELERATION) * delta 
	else:
		player.speed.x -= (AIR_DECCELERATION) * delta
	
	player.speed.x = clamp(player.speed.x, 0, AIR_MAX_SPEED) * player.multiplier 
	
	# Spajanje u velocity
	if player.get_platform and player.jump_count < 2:
		if !player.input_direction and (player.previous_state_ != player.fallingState):
			player.velocity.x = (player.speed.x * player.direction) + ( (player.last_platform_velocity.x / delta ) * time_for_velocity)
		else:
			player.velocity.x = (player.speed.x * player.direction)
	else:
		player.velocity.x = (player.speed.x * player.direction)
	if player.velocity.y >= 0:
		player.set_new_state(player.fallingState)
	
	returnRotation()


func input(_event):
	self.event = _event
	# ulaz u Jump State
	if event.is_action_pressed("jump") and player.jump_count < player.MAX_JUMP_COUNT:
		player.set_new_state(player.jumpingState)
	
func handleAnimation():
	# Krila Reposition
	if player.direction == 1:
		player.sprite_node.set_flip_h(true)
		player.kriloR.set_pos(Vector2(-15,-16))
		player.kriloL.set_pos(Vector2(8,-16))
	elif player.direction == -1:
		player.sprite_node.set_flip_h(false)
		player.kriloR.set_pos(Vector2(-8,-16))
		player.kriloL.set_pos(Vector2(15,-16))

func returnRotation():
	var velocity_vert_pos = make_positive(player.velocity.y) 
	player.next_rotation = ((player.jump_count * 6) * -player.direction) * delta

func exit():
	#player.sprite_node.set_modulate("FFFFFF")
	player.jump_count += 1
	pass
