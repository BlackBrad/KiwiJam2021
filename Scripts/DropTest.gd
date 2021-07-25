extends Area2D

signal connect_substance(substance)

var happy_sounds = []
var RandomGen

var connected_source = weakref(null)

func _ready():
	if $Audio1:
		happy_sounds += [$Audio1]
	if $Audio2:
		happy_sounds += [$Audio2]
	if $Audio3:
		happy_sounds += [$Audio3]
	RandomGen = RandomNumberGenerator.new()
	RandomGen.seed = OS.get_unix_time()

func play_happy_sound():
	var index = RandomGen.randi_range(0, happy_sounds.size() - 1)
	happy_sounds[index].play()

func connect_to_source(source):
	if connected_source.get_ref():
		return false
	else:
		connected_source = source
		print('drop_data called %s' % source)
		emit_signal('connect_substance', source)
		if happy_sounds:
			play_happy_sound()
		return true
