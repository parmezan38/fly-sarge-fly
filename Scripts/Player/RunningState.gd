extends "res://Scripts/Player/State.gd"

func getName():
	return "Running"

func enter(player):
	self.player = player
	#player.get_node("Sprite").set_modulate("FF0000")
	#player.jump_count = 1
	player.sarge_anim_player.play("run")
	player.run_anim_player.play("run")
	player.krila_anim_player.play("krilo_null")
	player.onair_time = 0
	if player.previous_state_ == player.fallingState:
		player.speed.x = player.speed.x / 2
	player.speed.y = 10
	player.is_in_air = false
	player.start_rotating_back = true
	pass

func input(_event):
	self.event = _event
	if event.is_action_pressed("move_right") or event.is_action_pressed("move_left"):
		player.sarge_anim_player.play("run")
	
	# ulaz u Jump State
	if event.is_action_pressed("jump") and player.jump_count < player.MAX_JUMP_COUNT:
		player.set_new_state(player.jumpingState)

func update(_delta):
	delta = _delta
	if player.input_direction:
		player.speed.x += (GROUND_ACCELERATION) * delta 
	else:
		player.speed.x -= (GROUND_DECCELERATION) * delta 
	# speed n player.velocity
	player.speed.y = 10  * player.multiplier 
	player.speed.x = clamp(player.speed.x, 0, GROUND_MAX_SPEED) * player.multiplier
	player.velocity.x = (player.speed.x * player.direction)
	player.velocity.y = player.speed.y 
	
	# ulaz u Idle State
	if player.input_direction == 0 and player.speed.x == 0:
		player.set_new_state(player.idleState)
	# ulaz u Falling State
	if !player.is_on_floor:
		player.set_new_state(player.fallingState)
	pass

func handleAnimation():
	# Run Animation
	var walk_anim_speed = 0.5 + player.speed.x / 500
	player.sarge_anim_player.set_speed(walk_anim_speed)
	player.run_anim_player.set_speed(walk_anim_speed)
	# Krila Reposition
	if player.direction == 1:
		player.sprite_node.set_flip_h(true)
		player.runDustSprite.set_flip_h(true)
		player.runDustSprite.set_pos( Vector2(-32, 35.5) )
		player.kriloL.set_pos(Vector2(6,-16) )
		player.kriloR.set_pos(Vector2(-18,-16) )
	elif player.direction == -1:
		player.runDustSprite.set_flip_h(false)
		player.sprite_node.set_flip_h(false)
		player.runDustSprite.set_pos( Vector2(30, 35.5) )
		player.kriloL.set_pos(Vector2(15,-16))
		player.kriloR.set_pos(Vector2(-8,-16))
	pass

func exit():
	#player.get_node("Sprite").set_modulate("ffffff")
	pass