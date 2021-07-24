extends Node2D

export(NodePath) var pipe_entrance_path

var source = weakref(null)

func _ready():
	var pipe_entrance = get_node(pipe_entrance_path)
	pipe_entrance.connect('connect_substance', self, 'on_connect_substance')

func on_connect_substance(substance_source):
	print('on_connect_substance called %s' % substance_source)
	source = substance_source

func _physics_process(delta):
	if source.get_ref():
		var substance = source.get_ref().drain_substance()
		print('Draining substance %s' % substance)
