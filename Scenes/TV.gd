extends Sprite

onready var _sink = $sink

const Globals = preload('res://Scripts/Globals.gd')

var source = weakref(null)

var current_effect = {}

var effect_status = {
	Globals.Substances.NONE: {},
	Globals.Substances.HOT_MILK: {
		Globals.Needs.A: 3.0,
		Globals.Needs.B: -3.0
	},
	Globals.Substances.OATS: {
		Globals.Needs.COMFORT: -3.0
	},
	Globals.Substances.SOY_SAUCE: {
		Globals.Needs.COMFORT: 2.0,
		Globals.Needs.TEMP: -1.0
	}
}


func _ready():
	_sink.connect('connect_substance', self, 'on_connect_substance')
	 
func on_connect_substance(substance_source):
	print('on_connect_substance called %s' % substance_source)
	source = substance_source

func _physics_process(delta):
	if source.get_ref():
		var substance = source.get_ref().drain_substance(delta)
		for key in effect_status[substance]:
			current_effect[key] = effect_status[substance][key]

func get_effect():
	return current_effect
