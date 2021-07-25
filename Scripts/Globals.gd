enum Needs {
	A,
	B,
	TEMP,
	COMFORT,
}

enum Substances {
	NONE,
	OATS,
	SOY_SAUCE,
	HOT_MILK,
}

const NeedInitValues = {
	Needs.A: {
		"decay": -1.0,
		"init": 50.0
	},
	Needs.B: {
		"decay": -2.0,
		"init": 75.0
	},
	Needs.TEMP: {
		"decay": -0.5,
		"init": 90.0
	},
	Needs.COMFORT: {
		"decay": -0.2,
		"init": 70.0
	}
}

static func get_init_decay(need):
	return NeedInitValues[need]["decay"]
	
static func get_init_val(need):
	return NeedInitValues[need]["init"]
