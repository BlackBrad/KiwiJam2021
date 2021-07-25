extends Node2D

onready var _sink = $sink

const Globals = preload('res://Scripts/Globals.gd')

var source = weakref(null)

var current_effect = {}

var effect_status = {
	Globals.Substances.OATS: {
		Globals.Needs.Repose: -3.0,
	},
	Globals.Substances.SOY_SAUCE: {
		Globals.Needs.Repose: 2.0,
	},
	Globals.Substances.HOT_MILK: {
		Globals.Needs.Pyrexia: 2.0
	},
	Globals.Substances.WASPS: {
		Globals.Needs.Unwasp: -1.0,
		Globals.Needs.Pyrexia: 3.0,
		Globals.Needs.Repose: -1.5,
		Globals.Needs.Stimulation: 2.5
	},
	Globals.Substances.GOBLINS: {
		Globals.Needs.Arcaena: 1.0,
		Globals.Needs.Repose: -4.0
	},
	Globals.Substances.PINKBATTS: {
		Globals.Needs.Pyrexia: 3.0,
		Globals.Needs.Arcaena: 0.5
	},
	Globals.Substances.AGGREGATE: {
		Globals.Needs.Repose: 2.5,
	},
	Globals.Substances.MILDEW: {
		Globals.Needs.Pyrexia: -1.0,
	},
	Globals.Substances.EFFLUENT: {
		Globals.Needs.Arcaena: -1.0,
		Globals.Needs.Unwasp: 1.5,
		Globals.Needs.Pyrexia: -1.5,
		Globals.Needs.Repose: -3.0
	},
	Globals.Substances.FONDANT: {
		Globals.Needs.Repose: 3.0
	},
	Globals.Substances.CIGGIES: {
		Globals.Needs.Unwasp: 2.0,
		Globals.Needs.Pyrexia: 3.0
	},
	Globals.Substances.NONE: {}
}

func _ready():
	_sink.connect('connect_substance', self, 'on_connect_substance')
	 

func on_connect_substance(substance_source):
	print('on_connect_substance called %s' % substance_source)
	source = substance_source

func _physics_process(delta):
	current_effect.clear()
	if source.get_ref():
		var substance = source.get_ref().drain_substance(delta)
		for key in effect_status[substance]:
			current_effect[key] = effect_status[substance][key]

func get_effect():
	return current_effect
