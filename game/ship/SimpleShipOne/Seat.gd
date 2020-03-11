extends KinematicBody

export var active = false

var simbody

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.set_process_input(active)
	$PoV/Camera.current = active
	
func set_active( active ):
	simbody = get_parent().get_parent().simbody
	$Control.set_process_input(active)
	$PoV/Camera.current = active
	$CollisionShape.disabled = active

func click():
	get_node("/root/Spaced/Player").change_body(self)
