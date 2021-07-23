extends Control

export(String) var label_name = "A"
export(float) var amount = 50.0
export(NodePath) var need_source_path

onready var label = $Label
onready var progress_bar = $ProgressBar

func _process(delta):
	label.text = label_name
	var need_source = get_node(need_source_path)
	if need_source:
		# TODO: Figure out how to parameterize this
		var source_amount = need_source.need_a
		progress_bar.value = int(source_amount)
	else:
		progress_bar.value = int(amount)

