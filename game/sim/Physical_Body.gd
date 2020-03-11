extends Node

enum BodyClass { NONE, CELESTIAL, SIMULATED, BUBBLE }
export (BodyClass) var body_class = BodyClass.NONE

var simbody

func _init():
	simbody = load("res://bin/orbsim_body.gdns").new()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/Spaced/Simulation").add_body_to_simulation(self)

func _exit_tree():
	simbody.queue_free()
