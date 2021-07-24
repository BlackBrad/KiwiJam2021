extends Area2D

const Globals = preload('res://Scripts/Globals.gd')
const DropTest = preload('res://Scripts/DropTest.gd')

export(Globals.Substances) var substance = Globals.Substances.NONE
export(float) var amount = 100.0
export(float) var rate = 1

onready var label = $Label
onready var audio_player = $AudioStreamPlayer

var _is_connected = false
var _target_position: Vector2
var _source_position: Vector2

var _source_rotation: float
var _target_rotation: float

var _velocity: Vector2
var _angular_velocity: float
var _mouse_in_area = false
var _sink = null

enum State {
	Idle,
	Dragging,
	Returning,
	Snapping,
}

var _state = State.Idle

signal on_empty

func _ready():
	connect('mouse_entered', self, 'on_mouse_entered')
	connect('mouse_exited', self, 'on_mouse_exited')
	connect('area_entered', self, 'on_area_entered')
	connect('area_exited', self, 'on_area_exited')
	label.text = Globals.Substances.keys()[substance]

func on_mouse_entered():
	_mouse_in_area = true

func on_mouse_exited():
	_mouse_in_area = false

func on_area_entered(area):
	print('area_entered')
	if area is DropTest:
		_sink = area

func on_area_exited(area):
	print('area_exited')
	if area == _sink:
		_sink = null

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			if _mouse_in_area and _state != State.Dragging:
				# Start dragging
				print('get_drag_data called')
				_state = State.Dragging
				_target_position = self.global_position
				_source_position = self.global_position
				_source_rotation = self.global_rotation
				_target_rotation = self.global_rotation
				audio_player.play()

		if _state == State.Dragging and not event.pressed:
			# Stop dragging
			if _sink:
				# Snap to sink
				print('snapping')
				audio_player.play()
				_is_connected = true
				_target_position = _sink.global_position
				_source_position = _sink.global_position
				_source_rotation = self.global_rotation
				_target_rotation = _sink.global_rotation
				_state = State.Snapping
				_sink.connect_to_source(weakref(self))
			else:
				# Return to original position
				_target_position = _source_position
				_target_rotation = _source_rotation
				_state = State.Returning

	if event is InputEventMouseMotion and _state == State.Dragging:
		_target_position = event.position

func _physics_process(delta):
	var acceleration = Vector2(0, 0)
	var target_position = _target_position
	var target_rotation = _target_rotation

	var friction = 19.0
	var strength = 400.0
	if _state == State.Snapping and _sink:
		target_position = _sink.global_position
		target_rotation = _sink.global_rotation
		strength = 700.0
		friction = 10.0

	if _state != State.Idle:
		var diff = target_position - self.global_position
		var dir = diff.normalized()
		acceleration = dir * strength * diff.length()

	_velocity += -_velocity * friction * delta
	_velocity += acceleration * delta

	self.global_position += _velocity * delta

	var angular_acceleration = 0.0
	if _state == State.Snapping:
		var diff = target_rotation - self.global_rotation
		print('diff %f' % diff)
		angular_acceleration = diff * 800.0
		print('angular_acceleration %f' % angular_acceleration)

	_angular_velocity += -_angular_velocity * 14.0 * delta;
	_angular_velocity += angular_acceleration * delta;
	self.global_rotation += _angular_velocity * delta;

func drain_substance(delta):
	if amount > rate:
		amount -= rate * delta
		return substance
	else:
		amount = 0
		emit_signal('on_empty')
		queue_free()
		return Globals.Substances.NONE

func on_connect_to_sink(position):
	audio_player.play()
	_is_connected = true
	_target_position = position
	_source_position = position
	_state = State.Snapping

func is_connected_to_sink():
	return _is_connected
