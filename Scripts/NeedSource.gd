extends Node2D

const Globals = preload('res://Scripts/Globals.gd')

export(float) var initial_need_a = 50.0
export(float) var initial_need_b = 75.0

export(float) var need_a_drain_rate = 1.0
export(float) var need_b_drain_rate = 2.0

export(NodePath) var pipe_entrance_path

var need_rates = {
	Globals.Needs.A: 0.0,
	Globals.Needs.B: 0.0,
}

var needs = {
	Globals.Needs.A: 0.0,
	Globals.Needs.B: 0.0,
}

func _ready():
	needs[Globals.Needs.A] = initial_need_a
	needs[Globals.Needs.B] = initial_need_b

	var pipe_entrance = get_node(pipe_entrance_path)
	pipe_entrance.connect('connect_substance', self, 'on_connect_substance')

func _physics_process(delta):
	needs[Globals.Needs.A] += -need_a_drain_rate * delta
	needs[Globals.Needs.B] += -need_b_drain_rate * delta

	for key in needs:
		needs[key] += need_rates[key] * delta
		needs[key] = clamp(needs[key], 0.0, 100.0)

func get_needs_value(key):
	return needs[key]

func on_connect_substance(substance):
	print('on_connect_substance called %s' % substance)
	if substance == Globals.Substances.OATS:
		need_rates[Globals.Needs.A] = 5.0
