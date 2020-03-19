extends Viewport

var global_camera
onready var camera = $Camera

# Called when the node enters the scene tree for the first time.
func _ready():
	var sky = get_node("/Player/Simulation/Global_Viewport/Global_Scene")
	global_camera = sky.add_camera(self)
	$Background.texture = global_camera

func get_basis():
	return camera.global_transform.basis
	
func get_global_position():
	return camera.global_transform.origin / 1000000


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
