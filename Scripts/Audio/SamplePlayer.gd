extends SamplePlayer
onready var player = get_parent()
func _ready():
	#set_default_volume(16.0)
	pass

func play_footstep():
	if player.state_ == player.runningState:
		var randNum = randi()%6+1
		if randNum == 1:
			play("footstep_01",true)
		elif randNum == 2:
			play("footstep_02",true)
		elif randNum == 3:
			play("footstep_03",true)
		elif randNum == 4:
			play("footstep_04",true)
		elif randNum == 5:
			play("footstep_05",true)
		elif randNum == 6:
			play("footstep_06",true)
	else:
		pass