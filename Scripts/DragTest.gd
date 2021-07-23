extends Control

func get_drag_data(position):
	print('get_drag_data called')
	var preview = self.duplicate()
	set_drag_preview(preview)
	return 0
