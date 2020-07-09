extends Node

export (NodePath) var global_bubble_path
var global_bubble : OrbitalBody

func _ready():
	pass

func get_global_bubble():
	return get_node(global_bubble_path)

func get_light_source():
	return get_node(light_source_path)
