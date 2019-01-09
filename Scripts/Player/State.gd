extends Object
# base STATE class
var event
var player = null
var delta 
const MAX_FALL_SPEED = 1500

var max_speed = 0
const GROUND_ACCELERATION = 500
const GROUND_DECCELERATION = 2100
const AIR_ACCELERATION = 1500
const AIR_DECCELERATION = 960 #960 original
const GROUND_MAX_SPEED = 475
const AIR_MAX_SPEED = 300

const GRAVITY = 1200
const MAX_FALL_SPEED = 1500
const STARTING_JUMP_FORCE = 290
const JUMP_FORCE_DECAY = 40
const MIN_ONAIR_TIME = 0.18
const JUMP_SPEED = 555
# 270 jump i 30 decay je okejjj ka, al moze bolje
var new_rotation = 0

func getName():
	#print("State.gd : " + str(player.get_name()))
	#assert(false)
	pass

func enter(player):
	self.player = player
	pass

func update(_delta):
	var delta = _delta
	pass

func input(_event):
	self.event = _event

func handleAnimation():
	pass

func exit():
	pass

func make_positive(num):
	if num < 0:
		num *= -1
	elif num == 0:
		num = 0
	else:
		num *= 1
	return num

func returnRotation():
	pass