extends OrbitalBody
class_name PlayerBody

var base_acceleration = Vector3()
export var velocity : Vector3

var pov 

onready var body : KinematicBody = $Body
onready var controller : Controller = $Control

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().add_to_local_objects(self)
	
func desactivate():
	set_process(false)
	set_physics_process(false)

func activate():
	set_process(true)
	set_physics_process(true)
	get_parent().set_bubble_anchor(simbody)
	
func _process(_delta):
	if (pov == null):
		pov = get_node("/root/Main/Player").pov
	pov.global_transform.origin = global_transform.origin

func _physics_process(delta):	
	simbody.acceleration = base_acceleration
	var center = get_parent().center
	var collision = body.move_and_collide(simbody.velocity_relative_to(center)*delta, true, true, true )
	if collision != null:
		var new_position = simbody.position_relative_to(center) - collision.remainder \
			+ collision.remainder.bounce(collision.normal) 
		simbody.set_position_relative_to(center, new_position)
		var damp = 0.2
		var dv = simbody.velocity_relative_to(center)-collision.collider_velocity
		var new_speed = damp*(dv.bounce(collision.normal) )
#		simbody.set_velocity_relative_to(collision.collider.simbody, new_speed)
		simbody.set_velocity_relative_to(center, new_speed + collision.collider_velocity)
		
	var p : Vector3 = simbody.position_relative_to(center)
	if p.length() < 50000:
		transform.origin = p
	else :
		print("plop")
	

#func _integrate_forces(physicState):
#	physicState.linear_velocity = $SimBody.simbody.velocity_relative_to(center)
#	print(center.position, $SimBody.simbody.position)
#	print( "Error = ", (transform.origin-$SimBody.simbody.position_relative_to(center)).length() )
