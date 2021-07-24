extends Control

const Globals = preload('res://Scripts/Globals.gd')

export(Globals.Substances) var substance = Globals.Substances.OATS

func get_drag_data(position):
	print('get_drag_data called')
	var preview = self.duplicate()
	set_drag_preview(preview)
	return substance
