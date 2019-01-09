extends "res://Scripts/Player/State.gd"

func getName():
	return "Idle"

func enter(player):
	self.player = player
	# promini boju u crveno
	#player.sprite_node.set_modulate("000000") 
	#player.jump_count = 1
	player.sarge_anim_player.play("breathing")
	player.krila_anim_player.play("krilo_null")
	player.run_anim_player.play("none")
	if player.previous_state_ == player.fallingState:
		player.stomp_anim_player.play("stomp")
	player.onair_time = 0 
	player.speed.y = 10
	player.speed.x = 0
	player.is_in_air = false
	player.start_rotating_back = true
	pass

func update(_delta):
	delta = _delta
	player.speed.y = 100
	player.speed.x = 0
	player.velocity.y = player.speed.y * player.multiplier 
	player.velocity.x = player.speed.x * player.multiplier
	
	
	# ulaz u Running State
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		player.set_new_state(player.runningState)
	
	# ulaz u Falling State
	if !player.is_on_floor and !player.ray_hit:
		player.set_new_state(player.fallingState)
	
	if player.is_on_cannonball:
		player.set_new_state(player.fallingState)

func input(_event):
	self.event = _event
	# ulaz u Jump State
	if event.is_action_pressed("jump") and player.jump_count < player.MAX_JUMP_COUNT:
		player.set_new_state(player.jumpingState)

func handleAnimation():
	pass

func exit():
	#promini boju u normalu
	#player.sprite_node.set_modulate("ffffff") 
	pass