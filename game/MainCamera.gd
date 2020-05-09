extends Camera

export (NodePath) var global_scene_path
var global_camera
var background

var zoom = false
onready var raycast = $RayCast


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("PoV")
		
func looking_at():
	return raycast.get_collider()
	
func _process(_delta):
	if Input.is_action_just_pressed("fps_zoom"):
		zoom = !zoom
		if zoom:
			fov=30
		else:
			fov = 70
		global_camera.camera.fov = fov
	global_camera.camera.global_transform.basis = global_transform.basis
	global_camera.camera.global_transform.origin = global_transform.origin / 1000000

func create_background_camera():
	#setup the global camera
	var global = get_node("/root/Main/Global")
	global_camera = global.add_pov(self)
	global_camera.camera.fov = fov
	global_camera.size = get_tree().get_root().size
	#setup the background to recieve the global camera view
	$Background/texture.texture = global_camera.get_texture()
