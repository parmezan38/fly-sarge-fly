extends Area2D

onready var playerSpace = get_parent().get_parent().get_parent().get_node("PlayerSpace")
var player

func _ready():
	set_fixed_process(true)
	pass
func _fixed_process(delta):
	if !player:
		if playerSpace.get_child_count() > 0:
			player = playerSpace.get_child(0)
	
	if overlaps_body(player): 
		player.reverser = -1
	else:
		pass
	pass