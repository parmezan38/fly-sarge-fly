extends Node2D
# Room Script za ROOM XXX - - -  R O O M
onready var startArea = get_node("StartArea")
onready var endArea = get_node("EndArea")
onready var roomEndArea = get_node("RoomEndArea")
onready var playerSpace = get_node("PlayerSpace")
onready var main = get_tree().get_root().get_node("Main")
onready var backgroundLabel = get_node("Background/Level_Info ")
onready var leverSprite = get_node("UnlockExitArea/Sprite")
onready var kinoSamplePlayer = get_node("KinoSamplePlayer")
const Player = preload("res://Object_Scenes/Player.tscn")
var player = null

export var PreviousRoom = ""
export var has_player_spawn = true
export var play_fade_in = false
var is_kino = true
func _ready():
	main.is_prev_scene_room = true
	if main.is_exit_open:
		leverSprite.set_frame(1)
	else:
		leverSprite.set_frame(0)
	set_fixed_process(true)
	if play_fade_in:
		main.playFadesAnimation("FromBlack")
	if not has_player_spawn:
		spawn_player()
	#backgroundLabel.set_text("current: " + str(get_name()) + "\n" + "next: " + str(PreviousRoom) )

func spawn_player():
	print("player: " + str(player))
	player = Player.instance()
	player.set_pos(startArea.get_global_pos())
	playerSpace.add_child(player)
	print("player parent: " + str(player.get_parent().get_name()))
	has_player_spawn = true
	pass

# Room End Area
func _on_RoomEndArea_body_enter( body ):
	if body.get_name() == "Player":
		backgroundLoadingShorter.goto_scene(str(PreviousRoom))
		body.is_paused = true
		var col4Room = roomEndArea.get_node("Col4Room")
		col4Room.set_pos( Vector2(3000,3000) )

# Unlock Exit
func _on_UnlockExitArea_body_enter( body ):
	if body.get_name() == "Player":
		if !main.is_exit_open:
			kinoSamplePlayer.play("klik",true)
		main.is_exit_open = true
		leverSprite.set_frame(1)
	pass # replace with function body
