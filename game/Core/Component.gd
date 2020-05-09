extends Spatial
class_name Component

export (String) var component_name : String
export (String) var system_name : String
var system : System

func set_system(sys : System)->void:
	system = sys

func setup()->void:
	pass
