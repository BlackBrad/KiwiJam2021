extends Node2D

const Globals = preload('res://Scripts/Globals.gd')

onready var _sink = $Character/Skeleton2D/root_jnt/chest_jnt/socket_jnt/adaptor_jnt/tube_jnt/Sink
onready var _animation_player = $AnimationPlayer
onready var _chair = $Recliner

export(NodePath) var death_screen_path

export(NodePath) var tv_path
var _tv

export(NodePath) var deathLabel

var source = weakref(null)
var death_screen

var is_alive = true

var needs = {}
var need_rates = {}
var world_decay_modifier = {}

var death_explination = "placeholder"

var boy_status_effects = {
	Globals.Substances.OATS: {
		Globals.Needs.Rapaciousness: 5.0,
		Globals.Needs.Aridity: -2.0,
	},
	Globals.Substances.SOY_SAUCE: {
		Globals.Needs.Rapaciousness: 2.0,
		Globals.Needs.Aridity: -1.0,
		Globals.Needs.Repose: -0.5,
		Globals.Needs.Unwasp: 3.0
	},
	Globals.Substances.HOT_MILK: {
		Globals.Needs.Aridity: 5.0,
		Globals.Needs.Repose: 3.0,
		Globals.Needs.Pyrexia: 2.0
	},
	Globals.Substances.WASPS: {
		Globals.Needs.Unwasp: -5.0,
		Globals.Needs.Rapaciousness: 8.0,
		Globals.Needs.Aridity: -1.0,
		Globals.Needs.Repose: -3.0,
		Globals.Needs.Stimulation: 1.0
	},
	Globals.Substances.GOBLINS: {
		Globals.Needs.Arcaena: 5.0,
		Globals.Needs.Rapaciousness: 3.0,
		Globals.Needs.Repose: -2.0
	},
	Globals.Substances.PINKBATTS: {
		Globals.Needs.Pyrexia: -5.0,
		Globals.Needs.Aridity: -4.0,
		Globals.Needs.Arcaena: 1.0
	},
	Globals.Substances.AGGREGATE: {
		Globals.Needs.Aridity: 4.0,
		Globals.Needs.Rapaciousness: 1.0,
	},
	Globals.Substances.MILDEW: {
		Globals.Needs.Aridity: 3.0,
		Globals.Needs.Rapaciousness: -2.0,
		Globals.Needs.Repose: -1.0,
	},
	Globals.Substances.EFFLUENT: {
		Globals.Needs.Arcaena: -5.0,
		Globals.Needs.Unwasp: 2.0,
		Globals.Needs.Pyrexia: 1.5,
	},
	Globals.Substances.FONDANT: {
		Globals.Needs.Repose: -4.0,
		Globals.Needs.Aridity: -1.0
	},
	Globals.Substances.CIGGIES: {
		Globals.Needs.Unwasp: 4.0,
		Globals.Needs.Pyrexia: 4.0,
		Globals.Needs.Rapaciousness: -3.0
	},
	Globals.Substances.REPELLANT: {
		Globals.Needs.Unwasp: 8.0,
		Globals.Needs.Repose: -4.0,
		Globals.Needs.Aridity: -5.0
	},
	Globals.Substances.NONE: {}
}


func _ready():
	_sink.connect('connect_substance', self, 'on_connect_substance')
	_animation_player.play('Idle')

	death_screen = get_node(death_screen_path)
	_tv = get_node(tv_path)
	
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
				
		
		var chair_effect = _chair.get_effect()
		for key in chair_effect:
			need_rates[key] += chair_effect[key]
			
		var tv_effect = _tv.get_effect()
		for key in tv_effect:
			need_rates[key] += tv_effect[key]
		
		for key in needs:
			needs[key] += need_rates[key] * delta
			needs[key] = clamp(needs[key], 0.0, 100.0)

		# Check for death
		for need in needs:
			if needs[need] <= 0.0: 
				death_explination = "Not enough " + Globals.Needs.keys()[need] +"!"
				on_death();
				is_alive = false
			elif needs[need] == 100.0:
				death_explination = "Too much " + Globals.Needs.keys()[need] + "!"
				on_death();
				is_alive = false

func get_needs_value(key):
	return needs[key]

func on_connect_substance(substance_source):
	print('on_connect_substance called %s' % substance_source)
	source = substance_source

func on_death():
	var deathLabelNode = get_node(deathLabel)
	deathLabelNode.set_text(death_explination)
	death_screen.play()
	
