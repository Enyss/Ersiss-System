extends "res://sim/Physical_Body.gd"

#Bodies in Local Scene
export (NodePath) var starting_body_path

var center
var player_body
var local_objects = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	center = simbody
	player_body = get_node(starting_body_path)
	player_body.set_active()
	player_body.set_controlled()
	_on_Center_Local_Bubble_timeout()
	pass # Replace with function body.

func add_to_local_objects(object):
	local_objects.append(object)

func _on_Center_Local_Bubble_timeout():
	center.set_position_relative_to(player_body.simbody, Vector3() )	
	center.set_velocity_relative_to(player_body.simbody, Vector3() )	
	for object in local_objects:
		object.transform.origin = object.simbody.position_relative_to(center)
