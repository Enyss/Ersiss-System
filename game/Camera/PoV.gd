extends Spatial

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
	viewport.size = viewport_size
	$Viewport3.size = viewport_size
	camera.fov = fov
#	camera_texture.texture = viewport.get_texture()

func _process(delta):
	camera.translation = global_transform.origin
	camera.global_transform.basis = global_transform.basis

func create_background_camera():
	sky = get_node("/root/Spaced/Player/Simulation/Global_Viewport/Global_Scene")
	global_camera = sky.add_pov(self)
	global_camera.camera.fov = camera.fov
	background = $Viewport/Background
	tex = global_camera.get_texture()
	background.texture = tex
	global_camera.size = viewport_size
