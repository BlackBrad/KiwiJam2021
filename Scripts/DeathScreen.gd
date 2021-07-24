extends ColorRect

onready var animation_player = $AnimationPlayer
export(NodePath) var retry_button_path

var retry_button

func _ready():
	hide()
	retry_button = get_node(retry_button_path)
	animation_player.connect('animation_finished', self, 'on_animation_finished')

func on_animation_finished(animation_name: String):
	print('animation finished')
	retry_button.show()

func play():
	show() # NOTE: This blocks player mouse interaction
	animation_player.play('FadeToBlack')
