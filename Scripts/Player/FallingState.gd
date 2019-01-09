extends "res://Scripts/Player/State.gd"
# FAAAAAAAAAAAAAAALING IN MY state
func getName():
	return "Falling"
func enter(player):
	self.player = player
	#promini boju u plavo za testiranje
	#player.sprite_node.set_modulate("FFBF00") 
	
	player.run_anim_player.play("none")
	if player.jump_count >= 4:
		player.krila_anim_player.play("krilo_null_falling")
	player.is_in_air = true
	#player.start_rotating_back = false

func update(_delta):
	delta = _delta
	player.speed.y += GRAVITY * delta * player.multiplier 
	player.velocity.y = player.speed.y * player.multiplier 
	if player.velocity.y > MAX_FALL_SPEED:
		player.velocity.y = MAX_FALL_SPEED
	
	# ulaz u Idle State ili Running State
	if player.is_on_floor and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")) and !player.is_on_cannonball:
		player.set_new_state(player.runningState)
	elif player.is_on_floor and !player.is_on_cannonball:
		player.set_new_state(player.idleState)
		player.return_to_origin_rot_new(delta)
	
	returnRotation(delta)

func input(_event):
	self.event = _event
	# ulaz u Jump State
	if event.is_action_pressed("jump") and player.jump_count < player.MAX_JUMP_COUNT:
		player.set_new_state(player.jumpingState)

func returnRotation(delta):
	player.next_rotation = player.next_rotation + (player.direction * delta * -2)
	pass

func handleAnimation():
	pass

func exit():
	player.play_thump()
	#promini boju u normalu
	#player.sprite_node.set_modulate("ffffff") 
	pass

