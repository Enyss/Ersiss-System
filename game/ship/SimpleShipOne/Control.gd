extends KinematicBody

export var active = false

var simbody

# Called when the node enters the scene tree for the first time.
#func _ready():
	#$Control.set_process_input(active)
#	$PoV/Camera.current = active
	
#func set_active( new_state ):
#	simbody = get_parent().get_parent().simbody
#	$Control.set_process_input(new_state)
#	active = new_state

func click():
	Player.set_controller($Control)
