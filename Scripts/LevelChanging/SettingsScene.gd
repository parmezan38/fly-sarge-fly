extends Control
onready var mainMenu = get_parent()
onready var levelSpace = get_parent().get_parent()
onready var musicCheck = get_node("VBoxContainer1/MusicCheck")
onready var musicVolume = get_node("VBoxContainer1/MusicVolume")
onready var sfxCheck = get_node("VBoxContainer1/SFXCheck")
onready var sfxVolume = get_node("VBoxContainer1/SFXVolume")
onready var fullscreen = get_node("VBoxContainer1/FullScreenCheck")
var config 
var musicMuteNew
var musicVolumeNew
var sfxMuteNew
var sfxVolumeNew
var fullscreenNew

func _ready():
	config = levelSpace.config
	musicCheck.set_pressed(config.music.mute)
	musicVolume.set_value(config.music.volume)
	sfxCheck.set_pressed(config.sfx.mute)
	sfxVolume.set_value(config.sfx.volume)
	fullscreen.set_pressed(config.resolution.fullscreen)
	set_process(true)
	pass

func _process(delta):
	musicMuteNew = musicCheck.is_pressed()
	musicVolumeNew = musicVolume. get_val()
	sfxMuteNew = sfxCheck.is_pressed()
	sfxVolumeNew = sfxVolume. get_val()
	fullscreenNew = fullscreen.is_pressed()
	
	AudioServer.set_stream_global_volume_scale(musicVolumeNew)
	AudioServer.set_fx_global_volume_scale(sfxVolumeNew)
	
	pass

func save_and_exit():
	config.music.mute = musicMuteNew
	config.music.volume = musicVolumeNew
	config.sfx.mute = sfxMuteNew
	config.sfx.volume = sfxVolumeNew
	config.resolution.fullscreen = fullscreenNew
	levelSpace.save_config_first_time()
	pass

func reload_values_from_file():
	config = levelSpace.config
	musicCheck.set_pressed(config.music.mute)
	musicVolume.set_value(config.music.volume)
	sfxCheck.set_pressed(config.sfx.mute)
	sfxVolume.set_value(config.sfx.volume)
	fullscreen.set_pressed(config.resolution.fullscreen)
	pass

func apply_values():
	pass

func _on_Save_pressed():
	save_and_exit()
	pass # replace with function body

