extends Spatial

var base_acceleration = Vector3()
export var velocity : Vector3
export (NodePath) var camera_viewport
var simbody

# Called when the node enters the scene tree for the first time.
func _ready():
	simbody = $SimBody.simbody
	get_parent().add_to_local_objects(self)
	
func set_active():
	pass
	
func set_controlled():
	pass
			
func _physics_process(delta):
	#rotate_x(delta/100)
	transform.origin = simbody.position_relative_to(get_parent().center,1)

#func _integrate_forces(physicState):
#	var center = get_parent().center
#	physicState.linear_velocity = $SimBody.simbody.velocity_relative_to(center)
#	print(center.position, $SimBody.simbody.position)
#	print( transform.origin, $SimBody.simbody.position_relative_to(center),\
#		 (transform.origin-$SimBody.simbody.position_relative_to(center)).length() )
