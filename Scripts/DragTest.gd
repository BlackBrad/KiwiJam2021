extends Control

const Globals = preload('res://Scripts/Globals.gd')

export(Globals.Substances) var substance = Globals.Substances.NONE
export(float) var amount = 100.0
export(float) var rate = 1

onready var label = $Label
onready var audio_player = $AudioStreamPlayer

var _is_connected = false

signal on_empty

func _ready():
	connect('mouse_entered', self, 'on_mouse_entered')
	connect('mouse_exited', self, 'on_mouse_exited')
	label.text = Globals.Substances.keys()[substance]

func get_drag_data(position):
	print('get_drag_data called')
	var preview = self.duplicate()
	set_drag_preview(preview)
	audio_player.play()
	return weakref(self)

func drain_substance():
	if amount > rate:
		amount -= rate
		return substance
	else:
		amount = 0
		emit_signal('on_empty')
		queue_free()
		return Globals.Substances.NONE

func on_mouse_entered():
	label.show()

func on_mouse_exited():
	label.hide()

func on_connect_to_sink():
	audio_player.play()
	_is_connected = true

func is_connected_to_sink():
	return _is_connected
