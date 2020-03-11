extends Node

var orbital_simulation
var simulation_speed = 1
var time =0.0
var simulated_bodies = Array()
var massive_bodies = Array()
var bubble_bodies = Array()

# Called when the node enters the scene tree for the first time.
func _init():
	orbital_simulation = load("res://bin/orbital_simulation.gdns").new()
	
func _ready():
	pass 

func _input(event):
	if event.is_action_pressed("sim_speed_up"):
		if (simulation_speed == 0):
			simulation_speed = 1
		else:
			simulation_speed *= 2
	if event.is_action_pressed("sim_speed_down"):
		simulation_speed /= 2


func _physics_process(delta):
	time += simulation_speed*delta
	for i in range(simulation_speed):
		orbital_simulation.update(delta)

func add_body_to_simulation(body):
	match body.body_class:
		body.BodyClass.CELESTIAL:
			massive_bodies.push_back(body)
			orbital_simulation.add_celestial_body(body.simbody)
		body.BodyClass.SIMULATED:
			simulated_bodies.push_back(body)
			orbital_simulation.add_simulated_body(body.simbody)
		body.BodyClass.BUBBLE:
			bubble_bodies.push_back(body)
			orbital_simulation.add_simulated_body(body.simbody)
			
func remove_body_from_simulation(body):
	print("remove_body_from_simulation not yet implemented")
