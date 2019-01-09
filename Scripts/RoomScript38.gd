extends Node2D
# Room 38
# 38
# 3  8
onready var startArea = get_node("StartArea")
onready var endArea = get_node("EndArea")
onready var roomEndArea = get_node("RoomEndArea")
onready var playerSpace = get_node("PlayerSpace")
onready var main = get_tree().get_root().get_node("Main")
onready var backgroundLabel = get_node("Background/Level_Info")
const Player = preload("res://Object_Scenes/Player.tscn")
var player = null

export var PreviousRoom = ""
export var NextRoom = ""
export var has_player_spawn = true
export var play_fade_in = false
var is_kino = true

func _ready():
	main.is_prev_scene_room = true
	set_fixed_process(true)
	if play_fade_in:
		main.playFadesAnimation("FromBlack")
	if not has_player_spawn:
		spawn_player()
	main.is_exit_open = true

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

func _on_RoomExitArea_body_enter( body ):
	if body.get_name() == "Player":
		backgroundLoadingShorter.goto_scene(str(NextRoom))
		body.is_paused = true
		var col4Room = roomEndArea.get_node("Col4Room")
		col4Room.set_pos( Vector2(3000,3000) )
	pass # replace with function body
