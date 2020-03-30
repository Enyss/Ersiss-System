extends KinematicBody

var base_acceleration = Vector3()
export var velocity : Vector3

var simbody
var controller
var pov

# Called when the node enters the scene tree for the first time.
func _ready():
	controller = $Control
	simbody = $SimBody.simbody
	get_parent().add_to_local_objects(self)
	
func desactivate():
	set_process(false)
	set_physics_process(false)

func activate():
	set_process(true)
	set_physics_process(true)
	get_tree().call_group("Bubble", "set_bubble_anchor", simbody)
	
func _process(delta):
	if (pov == null):
		pov = get_node("/root/Spaced/Player").pov
	pov.global_transform.origin = global_transform.origin
	simbody.acceleration = base_acceleration

func _physics_process(delta):	
	var center = get_parent().center
	var collision = move_and_collide(simbody.velocity_relative_to(center)*delta, true, true, true )
	if collision != null:
		var new_position = simbody.position_relative_to(center,1) - collision.remainder \
			+ collision.remainder.bounce(collision.normal) 
		simbody.set_position_relative_to(center, new_position,1)
		var damp = 0.2
		var dv = simbody.velocity_relative_to(center)-collision.collider_velocity
		var new_speed = damp*(dv.bounce(collision.normal) )
#		simbody.set_velocity_relative_to(collision.collider.simbody, new_speed)
		simbody.set_velocity_relative_to(center, new_speed + collision.collider_velocity)
		
	transform.origin = simbody.position_relative_to(center,1)
	

#func _integrate_forces(physicState):
#	physicState.linear_velocity = $SimBody.simbody.velocity_relative_to(center)
#	print(center.position, $SimBody.simbody.position)
#	print( "Error = ", (transform.origin-$SimBody.simbody.position_relative_to(center)).length() )
