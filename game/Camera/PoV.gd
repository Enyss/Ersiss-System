extends Component
class_name Pov

var sky
var global_camera
var background
var tex

export(float, 0, 180, 5) var fov = 70
export(Vector2) var viewport_size 
onready var viewport = $Viewport
onready var camera = $Viewport3/Camera
onready var camera_texture = $Viewport/CameraTexture

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("PoV")
	setup_viewport()
	setup_camera()
	
func _process(_delta):
	camera.translation = global_transform.origin
	camera.global_transform.basis = global_transform.basis

func setup_viewport():
	viewport.size = viewport_size
	$Viewport3.size = viewport_size

func setup_camera():
	camera.fov = fov
	global_camera = Scene.add_pov(self)
	global_camera.camera.fov = camera.fov
	background = $Viewport/Background
	tex = global_camera.get_texture()
	background.texture = tex
	global_camera.size = viewport_size
