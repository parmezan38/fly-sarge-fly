extends Node2D
onready var baza1 = get_node("Baza1")
onready var baza2 = get_node("Baza2")
onready var short1 = get_node("ShortMainMelodyGitHigh")
onready var short2 = get_node("ShortTinySwells")
onready var short3 = get_node("ShortSlide1")
onready var short4 = get_node("ShortGitChordsSloppy")
onready var medium1 = get_node("MediumMainMelodyLow")
onready var medium2 = get_node("MediumMainMelodyWobble")
onready var long1 = get_node("LongLoopMainMelody")
var currentBaza = null
var currentShort = null
var time = 0.0
var mute = false

func _ready():
	set_fixed_process(true)
	baza1.play(0)
	currentBaza = baza1
	currentShort = long1
	currentShort.play(0)

func _fixed_process(delta):
	time += delta
	# Baza
	if currentBaza == baza1:
		if !baza1.is_playing():
			if !baza2.is_playing():
				time = 0
				baza2.play(0)
				currentBaza = baza2
	elif currentBaza == baza2:
		if !baza2.is_playing():
			if !baza1.is_playing():
				time = 0
				baza1.play(0)
				currentBaza = baza1
	
	# Short
	if !currentShort.is_playing():
		var randNum = randi()%7+1
		if randNum == 1:
			currentShort = short1
		elif randNum == 2:
			currentShort = short2
		elif randNum == 3:
			currentShort = short3
		elif randNum == 4:
			currentShort = medium1
		elif randNum == 5:
			currentShort = medium2
		elif randNum == 6:
			currentShort = short4
		elif randNum == 7:
			currentShort = long1
		currentShort.play(0)
	if mute:
		currentBaza.set_volume(0)
		currentShort.set_volume(0)
	else:
		currentBaza.set_volume(1.99)
		currentShort.set_volume(1.99)