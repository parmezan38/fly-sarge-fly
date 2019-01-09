extends Node2D
export var animationName = "idle"
export var floatAnimationName = "float"
export var direction = -1
onready var spriteAnim = get_node("SpriteAnim")
onready var floatAnim = get_node("FloatAnim")
onready var kriloAnchor = get_node("All/KriloAnchor")
onready var krilo = get_node("All/KriloAnchor/Krilo")
onready var sprite = get_node("All/zlockoSprite")


# Float anim: float, counting
# Sprite anim: idle, counting, pointing, pulling, snikering, tea, clapping

func _ready():
	if direction == -1:
		kriloAnchor.set_pos(Vector2(2.6, -1.5))
		krilo.set_pos(Vector2(0.7, -0.3) )
		krilo.set_flip_h(false)
		sprite.set_flip_h(false)
	elif direction == 1:
		kriloAnchor.set_pos(Vector2(-26, -1.5))
		krilo.set_pos(Vector2(-12, -0.3))
		krilo.set_flip_h(true)
		sprite.set_flip_h(true)
	spriteAnim.play(animationName)
	floatAnim.play(floatAnimationName)
	pass
