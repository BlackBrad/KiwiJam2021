extends Control

const Globals = preload('res://Scripts/Globals.gd')

export(Globals.Substances) var substance = Globals.Substances.NONE
export(float) var amount = 100.0
export(float) var rate = 1

func get_drag_data(position):
	print('get_drag_data called')
	var preview = self.duplicate()
	set_drag_preview(preview)
	return self

func drain_substance():
	if amount > rate:
		amount -= rate
		return substance
	else:
		amount = 0
		return Globals.Substances.NONE
