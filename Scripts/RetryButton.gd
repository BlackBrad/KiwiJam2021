extends Button


func _ready():
	hide()
	connect('pressed', self, 'on_pressed')

func on_pressed():
	get_tree().reload_current_scene()
