enum Needs {
	Rapaciousness,
	Aridity,
	Pyrexia,
	Repose,
	Arcaena,
	Unwasp,
	Stimulation
}

enum Substances {
	NONE,
	OATS,
	SOY_SAUCE,
	HOT_MILK,
	WASPS,
	GOBLINS,
	PINKBATTS,
	AGGREGATE,
	MILDEW,
	EFFLUENT,
	FONDANT,
	REPELLANT,
	CIGGIES,
}

const NeedInitValues = {
	Needs.Rapaciousness: {
		"decay": -1.0,
		"init": 50.0
	},
	Needs.Aridity: {
		"decay": -2.0,
		"init": 75.0
	},
	Needs.Pyrexia: {
		"decay": -0.7,
		"init": 90.0
	},
	Needs.Repose: {
		"decay": -0.4,
		"init": 70.0
	},
	Needs.Arcaena: {
		"decay": -0.3,
		"init": 40
	},
	Needs.Unwasp: {
		"decay": 0.0,
		"init": 80
	},
	Needs.Stimulation: {
		"decay": -0.2,
		"init": 20
	}
}

static func get_init_decay(need):
	return NeedInitValues[need]["decay"]
	
static func get_init_val(need):
	return NeedInitValues[need]["init"]
