extends Node2D
var levelList = {}
# CONFIG CONFIG CONFIG CONFIG
func _ready():
	#do_everything_first_time() # Radi novi save file
	#load_game() # Enable to load save for normal play kad ima save data
	set_process(true)
	pass

func _process(delta):
	var file2Check = File.new()
	var doFileExists = file2Check.file_exists("res://config.save")
	if !doFileExists:
		print("No file saved!")
		do_everything_first_time()
		return
	
	if doFileExists:
		start_game()
		pass
	pass

func load_game():
	# Check if there is a saved file
	var file = File.new()
	if not file.file_exists("res://config.save"):
		print("No file saved!")
		return
	# Open existing file
	if file.open("res://config.save", File.READ) != 0:
		print("Error opening file")
		return
	
	config.parse_json(file.get_line())


func do_everything_first_time():
	config_first_time()
	save_config_first_time()


func save_config_first_time():
	var saveconfig = File.new()
	saveconfig.open("res://config.save", File.WRITE)
	saveconfig.store_line(config.to_json())
	saveconfig.close()

func config_first_time():
	config = {
		resolution = {"width":1920, "height":1080, "fullscreen":true,},
		music = {"volume":10, "mute":false},
		sfx = {"volume":10, "mute":false},
	}
