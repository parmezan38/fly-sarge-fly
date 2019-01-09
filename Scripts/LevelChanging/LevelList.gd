extends Node2D
var levelList = {}
var config = {}
func _ready():
	#do_everything_first_time() # Radi novi save file
	load_game() # Enable to load save for normal play kad ima save data
	pass
 
func load_game():
	# Check if there is a saved file
	var file = File.new()
	var configFile = File.new()
	# Save File check
	if not file.file_exists("res://savegame.save"):
		print("No save file saved!")
		return
	# Open existing file
	if file.open("res://savegame.save", File.READ) != 0:
		print("Error opening save file")
		return
	
	# Config File check
	if not configFile.file_exists("res://config.save"):
		print("No config file saved!")
		return
	# Open existing file
	if configFile.open("res://config.save", File.READ) != 0:
		print("Error opening config file")
		return
	
	levelList.parse_json(file.get_line())
	config.parse_json(configFile.get_line())


func do_everything_first_time():
	level_list_first_time()
	save_first_time()


func save_first_time():
	var savegame = File.new()
	savegame.open("res://savegame.save", File.WRITE)
	savegame.store_line(levelList.to_json())
	savegame.close()
	pass

func level_list_first_time():
	levelList = {
		level_000 = {"accessible":true, "number":000, "name":"level_000", "location":"res://Scenes/Level_000.tscn"},
		level_001 = {"accessible":false, "number":001, "name":"level_001", "location":"res://Scenes/Level_001.tscn"},
		level_002 = {"accessible":false, "number":002, "name":"level_002", "location":"res://Scenes/Level_002.tscn"},
		level_003 = {"accessible":false, "number":003, "name":"level_003", "location":"res://Scenes/Level_003.tscn"},
		level_004 = {"accessible":false, "number":004, "name":"level_004", "location":"res://Scenes/Level_004.tscn"},
		level_005 = {"accessible":false, "number":005, "name":"level_005", "location":"res://Scenes/Level_005.tscn"},
		level_006 = {"accessible":false, "number":006, "name":"level_006", "location":"res://Scenes/Level_006.tscn"},
		level_007 = {"accessible":false, "number":007, "name":"level_007", "location":"res://Scenes/Level_007.tscn"},
		level_008 = {"accessible":false, "number":008, "name":"level_008", "location":"res://Scenes/Level_008.tscn"},
		level_009 = {"accessible":false, "number":009, "name":"level_009", "location":"res://Scenes/Level_009.tscn"},
		level_010 = {"accessible":false, "number":010, "name":"level_010", "location":"res://Scenes/Level_010.tscn"},
		level_011 = {"accessible":false, "number":011, "name":"level_011", "location":"res://Scenes/Level_011.tscn"},
		level_012 = {"accessible":false, "number":012, "name":"level_012", "location":"res://Scenes/Level_012.tscn"},
		level_013 = {"accessible":false, "number":013, "name":"level_013", "location":"res://Scenes/Level_013.tscn"},
		level_014 = {"accessible":false, "number":014, "name":"level_014", "location":"res://Scenes/Level_014.tscn"},
		level_015 = {"accessible":false, "number":015, "name":"level_015", "location":"res://Scenes/Level_015.tscn"},
		level_016 = {"accessible":false, "number":016, "name":"level_016", "location":"res://Scenes/Level_016.tscn"},
		level_017 = {"accessible":false, "number":017, "name":"level_017", "location":"res://Scenes/Level_017.tscn"},
		level_018 = {"accessible":false, "number":018, "name":"level_018", "location":"res://Scenes/Level_018.tscn"},
		level_019 = {"accessible":false, "number":019, "name":"level_019", "location":"res://Scenes/Level_019.tscn"},
		level_020 = {"accessible":false, "number":020, "name":"level_020", "location":"res://Scenes/Level_020.tscn"},
		level_021 = {"accessible":false, "number":021, "name":"level_021", "location":"res://Scenes/Level_021.tscn"},
		level_022 = {"accessible":false, "number":022, "name":"level_022", "location":"res://Scenes/Level_022.tscn"},
		level_023 = {"accessible":false, "number":023, "name":"level_023", "location":"res://Scenes/Level_023.tscn"},
		level_024 = {"accessible":false, "number":024, "name":"level_024", "location":"res://Scenes/Level_024.tscn"},
		level_025 = {"accessible":false, "number":025, "name":"level_025", "location":"res://Scenes/Level_025.tscn"},
		level_026 = {"accessible":false, "number":026, "name":"level_026", "location":"res://Scenes/Level_026.tscn"},
		level_027 = {"accessible":false, "number":027, "name":"level_027", "location":"res://Scenes/Level_027.tscn"},
		level_028 = {"accessible":false, "number":028, "name":"level_028", "location":"res://Scenes/Level_028.tscn"},
		level_029 = {"accessible":false, "number":029, "name":"level_029", "location":"res://Scenes/Level_029.tscn"},
		level_030 = {"accessible":false, "number":030, "name":"level_030", "location":"res://Scenes/Level_030.tscn"},
		level_031 = {"accessible":false, "number":031, "name":"level_031", "location":"res://Scenes/Level_031.tscn"},
		level_032 = {"accessible":false, "number":032, "name":"level_032", "location":"res://Scenes/Level_032.tscn"},
		level_033 = {"accessible":false, "number":033, "name":"level_033", "location":"res://Scenes/Level_033.tscn"},
		level_034 = {"accessible":false, "number":034, "name":"level_034", "location":"res://Scenes/Level_034.tscn"},
		level_035 = {"accessible":false, "number":035, "name":"level_035", "location":"res://Scenes/Level_035.tscn"},
		level_036 = {"accessible":false, "number":036, "name":"level_036", "location":"res://Scenes/Level_036.tscn"},
		level_037 = {"accessible":false, "number":037, "name":"level_037", "location":"res://Scenes/Level_037.tscn"},
		level_038 = {"accessible":false, "number":038, "name":"level_038", "location":"res://Scenes/Level_038.tscn"},
		level_039 = {"accessible":false, "number":039, "name":"level_039", "location":"res://Scenes/Level_039.tscn"},
		level_040 = {"accessible":false, "number":040, "name":"level_040", "location":"res://Scenes/Level_040.tscn"},
		room_003 = {"accessible":false, "number":003, "name":"room_003", "location":"res://Scenes/Room_003.tscn"},
	}
	pass

# CONFIG
func config_first_time():
	config = {
		resolution = {"width":1920, "height":1080, "fullscreen":true,},
		music = {"volume":2.5, "mute":false},
		sfx = {"volume":3.5, "mute":false},
	}

func save_config_first_time():
		var saveconfig = File.new()
		saveconfig.open("res://config.save", File.WRITE)
		saveconfig.store_line(config.to_json())
		saveconfig.close()
