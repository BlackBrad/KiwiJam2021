extends Node2D

export(float) var need_a = 50.0
export(float) var need_b = 75.0

export(float) var need_a_drain_rate = 1.0
export(float) var need_b_drain_rate = 2.0

func _physics_process(delta):
	need_a -= need_a_drain_rate * delta
	need_b -= need_b_drain_rate * delta
