extends Button


func _ready():
	connect('pressed', self, 'on_pressed')

func on_pressed():
	SceneSwitcher.goto_scene('res://Scenes/NeedsTest.tscn')
