extends Control

signal connect_substance(substance)

func can_drop_data(position, data):
	# FIXME: This doesn't prevent you connecting a source to two different sinks
	var substance_source = data.get_ref()
	if substance_source:
		if substance_source.is_connected_to_sink():
			return false

	print('can_drop_data called')
	return true

func drop_data(position, data):
	print('drop_data called %s' % data)
	emit_signal('connect_substance', data)
