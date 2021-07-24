extends Node2D

const Globals = preload('res://Scripts/Globals.gd')

export(PackedScene) var substance_scene
export(float) var spawn_time = 30.0
onready var timer = $Timer

func _ready():
	on_timeout()
	timer.connect('timeout', self, 'on_timeout')
	timer.wait_time = spawn_time

func on_timeout():
	var substance = substance_scene.instance()
	substance.substance = Globals.Substances.HOT_MILK
	substance.amount = 100
	substance.rate = 0.1
	substance.connect('on_empty', self, 'on_empty')
	add_child(substance)
	print('spawn substance')

func on_empty():
	print('on_empty')
	timer.start()
