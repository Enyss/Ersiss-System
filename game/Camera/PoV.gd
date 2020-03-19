extends Spatial

var sky
var global_camera
var background
var tex

onready var viewport = $Viewport
onready var camera = $Viewport3/Camera

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("PoV")

func _process(delta):
	camera.translation = global_transform.origin
	camera.global_transform.basis = global_transform.basis

func create_background_camera():
	sky = get_node("/root/Spaced/Player/Simulation/Global_Viewport/Global_Scene")
	global_camera = sky.add_pov(self)
	background = $Viewport/Background
	tex = global_camera.get_texture()
	background.texture = tex
