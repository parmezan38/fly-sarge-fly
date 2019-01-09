extends VideoPlayer
export var loop = false
func _ready():
	set_process(true)
	pass
func _process(delta):
	if !is_playing():
		if loop:
			play()
