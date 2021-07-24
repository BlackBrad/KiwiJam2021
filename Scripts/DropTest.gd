extends Area2D

signal connect_substance(substance)

func connect_to_source(source):
	print('drop_data called %s' % source)
	emit_signal('connect_substance', source)
