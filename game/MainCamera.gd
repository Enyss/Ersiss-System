extends Camera

export (NodePath) var global_scene_path
var global_camera
export (NodePath) var background_path
var background

onready var raycast = $RayCast


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("PoV")
		
func looking_at():
	return raycast.get_collider()
	
func _process(delta):
	global_camera.camera.global_transform.basis = global_transform.basis
	global_camera.camera.global_transform.origin = global_transform.origin / 1000000

func create_background_camera():
	#setup the global camera
	var sky = get_node(global_scene_path)
	global_camera = sky.add_pov(self)
	global_camera.camera.fov = fov
	global_camera. size = get_tree().get_root().size
	#setup the background to recieve the global camera view
	background = get_node(background_path)
	background.texture = global_camera.get_texture()
