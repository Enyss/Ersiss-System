extends RigidBody

var base_acceleration = Vector3()
export var position_in_km : Vector3
export var velocity : Vector3

var simbody

# Called when the node enters the scene tree for the first time.
func _ready():
	simbody = $SimBody.simbody
	simbody.position = 1000*position_in_km
	simbody.velocity = velocity
	get_parent().add_to_local_objects(self)
	
func set_active():
	$PoV/Camera.current = true
	
func set_controlled():
	$Control.set_active()
			
func _process(delta):
	simbody.acceleration = base_acceleration


func _integrate_forces(physicState):
	physicState.linear_velocity = simbody.velocity_relative_to(get_parent().center)
