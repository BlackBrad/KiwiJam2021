extends Node2D

const Globals = preload('res://Scripts/Globals.gd')

export(NodePath) var pipe_entrance_path
export(NodePath) var death_screen_path

export(NodePath) var chair_path
var chair_node

var source = weakref(null)
var death_screen

var is_alive = true

var needs = {}
var need_rates = {}
var world_decay_modifier = {}

var boy_status_effects = {
	Globals.Substances.OATS: {
		Globals.Needs.A: 5.0,
		Globals.Needs.B: -2.0
	},
	Globals.Substances.SOY_SAUCE: {
		Globals.Needs.A: -1.0,
		Globals.Needs.B: 3.0
	},
	Globals.Substances.HOT_MILK: {
		Globals.Needs.A: 0,
		Globals.Needs.B: 5.0
	},
	Globals.Substances.NONE: {}
}


func _ready():
	var pipe_entrance = get_node(pipe_entrance_path)
	pipe_entrance.connect('connect_substance', self, 'on_connect_substance')

	death_screen = get_node(death_screen_path)
	chair_node = get_node(chair_path)
	
	for need in Globals.Needs:
		var need_val = Globals.Needs[need]
		need_rates[need_val] = 0
		needs[need_val] = Globals.get_init_val(need_val)

func _physics_process(delta):
	if is_alive:
		for need in need_rates:
			need_rates[need] = Globals.get_init_decay(need)
			if world_decay_modifier.has(need):
				need_rates[need] += world_decay_modifier[need]

		if source.get_ref():
			print("Got source!")
			var substance = source.get_ref().drain_substance(delta)
			for key in boy_status_effects[substance]:
				print("Apply")
				print(boy_status_effects[substance][key])
				need_rates[key] += boy_status_effects[substance][key]
				
		
		if chair_node:
			var chair_effect = chair_node.get_effect()
			for key in chair_effect:
				need_rates[key] += chair_effect[key]
		
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
	
