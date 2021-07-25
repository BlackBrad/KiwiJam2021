extends Area2D

signal connect_substance(substance)

onready var happy_sounds = [$Happy1, $Happy2, $Happy3]
var RandomGen

func _ready():
	RandomGen = RandomNumberGenerator.new()
	RandomGen.seed = OS.get_unix_time()

func play_happy_sound():
	var index = RandomGen.randi_range(0, happy_sounds.size() - 1)
	happy_sounds[index].play()

func connect_to_source(source):
	print('drop_data called %s' % source)
	emit_signal('connect_substance', source)
	if happy_sounds[0]:
		play_happy_sound()
