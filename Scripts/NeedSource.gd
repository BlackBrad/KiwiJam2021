extends Node2D

export(float) var initial_need_a = 50.0
export(float) var initial_need_b = 75.0

export(float) var need_a_drain_rate = 1.0
export(float) var need_b_drain_rate = 2.0

var needs = {
	"A": 0,
	"B": 0,
}

func _ready():
	needs["A"] = initial_need_a
	needs["B"] = initial_need_b

func _physics_process(delta):
	needs["A"] -= need_a_drain_rate * delta
	needs["B"] -= need_b_drain_rate * delta

func get_needs_value(key: String):
	return needs[key]
