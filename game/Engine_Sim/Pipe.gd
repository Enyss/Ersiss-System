extends Spatial

export (float) var input_section
export (float) var output_section

export var input = {"section":1.0, "pressure":1.0, "speed":1.0}
export var output = {"section":1.0, "pressure":1.0, "speed":1.0}

signal output(connexion)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _equalize_output(out):
	var pressure = out.

func _process_physics(delta):
	
	pass
