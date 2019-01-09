# LEVEL STATE

var player = null

# Return the unique string name of the state. Must be overridden.
func get_name():
    assert(false)

# Handle any transitions into this state. Subclasses should first chain to this method.
func enter(player):
    self.player = player
    _animate()

# Transition to a new animation; by default, one matching the name of the State (if it exists).
# Can be overridden without chaining.
func _animate():
    var name = get_name()
    if player.animation_player.has_animation(name):
            player.animation_player.play(name)

# Handle input events.
func _input(event):
    pass

# Update physics processing.
func _fixed_process(delta):
    pass

# Handle exit events.
func exit():
    pass