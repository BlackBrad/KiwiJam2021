extends Control

const Globals = preload('res://Scripts/Globals.gd')

export(String) var label_name = "<NEED NAME>"
export(Globals.Needs) var need_key = Globals.Needs.Rapaciousness
export(NodePath) var need_source_path

onready var label = $Label
onready var progress_bar = $ProgressBar

func _ready():
	label.text = label_name
	
func _process(delta):
	var need_source = get_node(need_source_path)
	var source_amount = need_source.get_needs_value(need_key)
	progress_bar.value = int(source_amount)
