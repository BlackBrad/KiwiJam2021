extends Control

signal connect_substance(substance)

func can_drop_data(position, data):
	print('can_drop_data called')
    # Check position if it is relevant to you
    # Otherwise, just check data
    #return typeof(data) == TYPE_DICTIONARY and data.has("expected")
	return true

func drop_data(position, data):
	print('drop_data called %s' % data)
	emit_signal('connect_substance', data)
