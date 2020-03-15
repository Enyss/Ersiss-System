extends Spatial

var local_velocity = Vector3()
var simbody
var bubble
# Called when the node enters the scene tree for the first time.
func _ready():
	simbody = $SimBody.simbody
	bubble = get_parent().bubble
	bubble.add_to_local_objects(self)
	simbody.set_position_relative_to(bubble.center, Vector3(0,0,0), 1)
	simbody.set_velocity_relative_to(bubble.center, get_parent().generate_velocity() )

func _physics_process(delta):
	translation = simbody.position_relative_to(bubble.center,1)
	
