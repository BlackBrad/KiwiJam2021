extends Control

const Globals = preload('res://Scripts/Globals.gd')

export(String) var label_name = "<NEED NAME>"
export(Globals.Needs) var need_key = Globals.Needs.Rapaciousness
export(NodePath) var need_source_path

onready var label = $Label
onready var progress_bar = $ProgressBar
onready var increase_indicator = $ProgressBar/IncreaseArrow
onready var decrease_indicator = $ProgressBar/DecreaseArrow

var _old_amount = 0.0

func _ready():
	label.text = label_name
	increase_indicator.hide()
	decrease_indicator.hide()

func _physics_process(delta):
	var need_source = get_node(need_source_path)
	var source_amount = need_source.get_needs_value(need_key)
	progress_bar.value = int(source_amount)

	if source_amount - _old_amount > 0.01:
		increase_indicator.show()
		decrease_indicator.hide()
	elif source_amount - _old_amount < -0.01:
		decrease_indicator.show()
		increase_indicator.hide()
	else:
		increase_indicator.hide()
		decrease_indicator.hide()

	_old_amount = source_amount
  