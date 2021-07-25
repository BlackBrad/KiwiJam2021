extends Sprite

onready var _sink = $sink

const Globals = preload('res://Scripts/Globals.gd')

var source = weakref(null)

var current_effect = {}

enum TV_Shows {
	DRY,
	ACTION,
	EROTIC,
	MASH,
	NEWS,
	DOOLITTLE,
	NATURE
}

var tv_effects = {
	TV_Shows.DRY: {
		Globals.Needs.Aridity: -1.0,
		Globals.Needs.Stimulation: -2.0,
		Globals.Needs.Rapaciousness: -0.5,
	},
	TV_Shows.ACTION:{
		Globals.Needs.Stimulation: 3.0,
		Globals.Needs.Repose: -1.0,
	},
	TV_Shows.EROTIC: {
		Globals.Needs.Pyrexia: 3.0,
		Globals.Needs.Unwasp: -1.0,
		Globals.Needs.Repose: -1.0,
		Globals.Needs.Stimulation: 3.0
	},
	TV_Shows.MASH: {
		Globals.Needs.Aridity: 2.0,
		Globals.Needs.Rapaciousness: 3.0,
		Globals.Needs.Stimulation: 1.2
	},
	TV_Shows.NEWS: {
		Globals.Needs.Stimulation: -3.0,
		Globals.Needs.Aridity: -1.5,
		Globals.Needs.Pyrexia: -2.0
	},
	TV_Shows.DOOLITTLE: {
		Globals.Needs.Arcaena: 3.5,
		Globals.Needs.Unwasp: -1.5,
		Globals.Needs.Repose: 3.2,
		Globals.Needs.Stimulation: 2.7
	},
	TV_Shows.NATURE: {
		Globals.Needs.Unwasp: -1.5,
		Globals.Needs.Aridity: 2.0,
		Globals.Needs.Arcaena: -0.5,
		Globals.Needs.Repose: 1.5,
		Globals.Needs.Stimulation: -1.5
	}
}

var tv_map = {
	Globals.Substances.OATS: TV_Shows.DRY,
	Globals.Substances.SOY_SAUCE: TV_Shows.MASH,
	Globals.Substances.HOT_MILK: TV_Shows.EROTIC,
	Globals.Substances.WASPS: TV_Shows.DOOLITTLE,
	Globals.Substances.GOBLINS: TV_Shows.DOOLITTLE,
	Globals.Substances.PINKBATTS: TV_Shows.DRY,
	Globals.Substances.AGGREGATE: TV_Shows.NEWS,
	Globals.Substances.MILDEW: TV_Shows.NATURE,
	Globals.Substances.EFFLUENT: TV_Shows.NEWS,
	Globals.Substances.FONDANT: TV_Shows.MASH,
	Globals.Substances.CIGGIES: TV_Shows.EROTIC,
	Globals.Substances.REPELLANT: TV_Shows.ACTION
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
		if substance != Globals.Substances.NONE:
			var tv_mapping = tv_map[substance]
			for key in tv_effects[tv_mapping]:
				current_effect[key] = tv_effects[tv_mapping][key]

func get_effect():
	return current_effect
