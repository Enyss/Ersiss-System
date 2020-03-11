extends KinematicBody

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
	
func set_active( active ):
	$Control.set_process(active)
	$PoV.set_process_input(active)
	$PoV/Camera.current = active
			
func _process(delta):
	simbody.acceleration = base_acceleration

func _physics_process(delta):	
	var center = get_parent().center
	var collision = move_and_collide(simbody.velocity_relative_to(center)*delta, true, true, true )
	if collision != null:
		var new_position = simbody.position_relative_to(center) - collision.remainder \
			+ collision.remainder.bounce(collision.normal) 
		simbody.set_position_relative_to(center, new_position)
		var damp = 0.2
		var dv = simbody.velocity_relative_to(center)-collision.collider_velocity
		var new_speed = damp*(dv.bounce(collision.normal) )
		simbody.set_velocity_relative_to(collision.collider.simbody, new_speed)
		
	transform.origin = simbody.position_relative_to(center)
	

#func _integrate_forces(physicState):
#	physicState.linear_velocity = $SimBody.simbody.velocity_relative_to(center)
#	print(center.position, $SimBody.simbody.position)
#	print( "Error = ", (transform.origin-$SimBody.simbody.position_relative_to(center)).length() )
