extends Node2D

const Globals = preload('res://Scripts/Globals.gd')

export(PackedScene) var substance_scene
export(float) var spawn_time = 30.0
onready var timer = $Timer

const spawn_table = [
	{ 
		'substance': Globals.Substances.OATS,
		'amount': 100,
		'rate': 17,
		'label': Color(1, 0, 0, 1)
	},
	{ 
		'substance': Globals.Substances.SOY_SAUCE,
		'amount': 100,
		'rate': 20,
		'label': Color(1, 0, 0, 1)
	},
	{ 
		'substance': Globals.Substances.HOT_MILK,
		'amount': 100,
		'rate': 30,
		'label': Color(1, 0, 0, 1)
	},
		{ 
		'substance': Globals.Substances.AGGREGATE,
		'amount': 100,
		'rate': 30,
		'label': Color(1, 0, 0, 1)
	},
	{ 
		'substance': Globals.Substances.CIGGIES,
		'amount': 100,
		'rate': 25,
		'label': Color(1, 0, 0, 1)
	},
	{ 
		'substance': Globals.Substances.EFFLUENT,
		'amount': 100,
		'rate': 20,
		'label': Color(1, 0, 0, 1)
	},
		{ 
		'substance': Globals.Substances.FONDANT,
		'amount': 100,
		'rate': 15,
		'label': Color(1, 0, 0, 1)
	},
	{ 
		'substance': Globals.Substances.GOBLINS,
		'amount': 100,
		'rate': 11,
		'label': Color(1, 0, 0, 1)
	},
	{ 
		'substance': Globals.Substances.MILDEW,
		'amount': 100,
		'rate': 30,
		'label': Color(1, 0, 0, 1)
	},
	{ 
		'substance': Globals.Substances.PINKBATTS,
		'amount': 100,
		'rate': 15,
		'label': Color(1, 0, 0, 1)
	},
	{ 
		'substance': Globals.Substances.REPELLANT,
		'amount': 100,
		'rate': 35,
		'label': Color(1, 0, 0, 1)
	},
	{ 
		'substance': Globals.Substances.WASPS,
		'amount': 100,
		'rate': 20,
		'label': Color(1, 0, 0, 1)
	},
]

func _ready():
	on_timeout()
	timer.connect('timeout', self, 'on_timeout')
	timer.wait_time = spawn_time

func on_timeout():
	var substance = substance_scene.instance()
	var index = randi() % spawn_table.size()
	substance.substance = spawn_table[index]['substance']
	substance.amount = spawn_table[index]['amount']
	substance.rate = spawn_table[index]['rate']
	substance.y_bounce = self.global_position.y
	substance.label_color = spawn_table[index]["label"]
	substance.connect('on_empty', self, 'on_empty')
	add_child(substance)
	substance.global_position.y -= rand_range(150, 300)
	print('spawn substance')

func on_empty():
	print('on_empty')
	timer.start()
