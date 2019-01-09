extends RigidBody2D

func _ready():
	set_process(true) 
	pass
	
func _process(delta):
	var velocity = get_linear_velocity()
	get_node("Label").set_text(str(velocity))
	pass
