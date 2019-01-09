extends Node2D
# Level Script za LEVEL XXX
onready var startArea = get_node("StartArea")
onready var endArea = get_node("EndArea")
onready var endAreaCollision = get_node("EndArea/EndCollision")
onready var playerSpace = get_node("PlayerSpace")
onready var main = get_tree().get_root().get_node("Main")
onready var backgroundLabel = get_node("Background/Level_Info")
onready var roomExit = get_node("RoomEndArea/RoomExit")
onready var roomEndArea = get_node("RoomEndArea")
onready var exitGateSprite = get_node("ExitGate/ExitGateSprite")
const Player = preload("res://Object_Scenes/Player.tscn")
var player = null
var spawnPos = Vector2()

export var NextScene = ""
export var NextRoom = ""
export var has_player_spawn = true
export var play_fade_in = false
export var backgroundVersion = 1
export var is_end_level = false
var levelSpace
var levelList
var level
var is_kino = false

export var is_exit_open = false

func _ready():
	levelSpace = get_parent()
	levelList = levelSpace.levelList
	findFromDictionary()
	if !is_end_level:
		main.get_node("LevelName").set_text(str(int(level.number) - 1) )
	else:
		main.get_node("LevelName").set_text( str(39) )
	
	# Is Exit Open 
	if main.is_prev_scene_room:
		is_exit_open = main.is_exit_open
		pass
	else:
		main.is_exit_open = is_exit_open
	
	if !main.is_prev_scene_room:
		spawnPos = startArea.get_pos()
	else:
		spawnPos = roomExit.get_global_pos()
	
	if main.is_exit_open:
		exitGateSprite.set_frame(1)
	else:
		exitGateSprite.set_frame(0)
	
	play_fade_in = true
	if play_fade_in:
		main.playFadesAnimation("FromBlackWithTitle")
	if not has_player_spawn:
		spawn_player()
	backgroundLabel.set_text("current: " + str(get_name()) + "\n" + "next: " + str(NextScene) + "\n" + "room: " + str(NextRoom))
	
	if is_exit_open:
		endArea.get_node("SpriteClosed").hide()
		endArea.get_node("Sprite").show()
	else:
		endAreaCollision.set_pos( Vector2(-200,-200) )
		endArea.get_node("SpriteClosed").show()
		endArea.get_node("Sprite").hide()

func spawn_player():
	player = Player.instance()
	player.set_pos(spawnPos)
	playerSpace.add_child(player)
	has_player_spawn = true
	main.is_prev_scene_room = false
	pass

# End Area
func _on_EndArea_body_enter( body ):
	if body.get_name() == "Player":
		if !is_end_level:
			backgroundLoading.goto_scene(str(NextScene))
			body.is_paused = true
			endArea.get_node("EndCollision").set_pos( Vector2(3000,3000) )
			level.accessible = true
			levelSpace.save_first_time()
			endArea.get_node("SamplePlayer").play("blingsingle",false)
		else:
			backgroundLoading.goto_scene(str(NextScene))
			body.is_paused = true
			endArea.get_node("EndCollision").set_pos( Vector2(3000,3000) )
			endArea.get_node("SamplePlayer").play("blingsingle",false)

# Room End Area
func _on_RoomEndArea_body_enter( body ):
	if body.get_name() == "Player":
		backgroundLoading.goto_scene(str(NextRoom))
		body.is_paused = true
		var col4Room = roomEndArea.get_node("Col4Room")
		col4Room.set_pos( Vector2(3000,3000) )

func findFromDictionary():
	for i in levelList:
		if levelList[i].location == NextScene:
			level = levelList[i]
