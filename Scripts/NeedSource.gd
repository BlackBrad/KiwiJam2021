extends Node2D

const Globals = preload('res://Scripts/Globals.gd')

export(float) var initial_need_a = 50.0
export(float) var initial_need_b = 75.0

export(float) var need_a_drain_rate = -1.0
export(float) var need_b_drain_rate = -2.0

export(NodePath) var pipe_entrance_path
export(NodePath) var death_screen_path

var source = weakref(null)
var death_screen

var is_alive = true

var needs = {
	Globals.Needs.A: 0.0,
	Globals.Needs.B: 0.0,
}

var boy_status_effects = {
	Globals.Substances.OATS: {
		Globals.Needs.A: 5.0,
		Globals.Needs.B: -2.0
	},
	Globals.Substances.SOY_SAUCE: {
		Globals.Needs.A: -1.0,
		Globals.Needs.B: 3.0
	},
	Globals.Substances.HOT_WATER: {
		Globals.Needs.A: 0,
		Globals.Needs.B: 5.0
	},
	Globals.Substances.NONE: {}
}

func _ready():
	needs[Globals.Needs.A] = initial_need_a
	needs[Globals.Needs.B] = initial_need_b

	var pipe_entrance = get_node(pipe_entrance_path)
	pipe_entrance.connect('connect_substance', self, 'on_connect_substance')

	death_screen = get_node(death_screen_path)

func _physics_process(delta):
	var decay_rates = {}
	if is_alive:
		decay_rates = {
			Globals.Needs.A: need_a_drain_rate,
			Globals.Needs.B: need_b_drain_rate
		}
		var need_rates = {}
		
		for need in decay_rates:
			need_rates[need] = decay_rates[need]

		if source.get_ref():
			var substance = source.get_ref().drain_substance(delta)
			print("Applying effect:")
			print(boy_status_effects[substance])
			for key in boy_status_effects[substance]:
				need_rates[key] += boy_status_effects[substance][key]
		
		for key in needs:
			needs[key] += need_rates[key] * delta
			needs[key] = clamp(needs[key], 0.0, 100.0)

		# Check for death
		for need in needs:
			if needs[need] <= 0.0: 
				on_death();
				is_alive = false

func get_needs_value(key):
	return needs[key]

func on_connect_substance(substance_source):
	print('on_connect_substance called %s' % substance_source)
	source = substance_source

func on_death():
	death_screen.play()
	
