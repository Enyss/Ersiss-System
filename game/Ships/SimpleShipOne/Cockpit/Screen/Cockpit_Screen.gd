extends Component

var screen_material
var pov
var camera_view

# Called when the node enters the scene tree for the first time.
func _ready():
	var p = "res://ship/SimpleShipOne/Cockpit/Screen/new_spatialmaterial.tres"
	screen_material = load(p)
	
func setup():
	system.connect("camera_changed", self, "on_camera_change")
	#pov = get_node(pov_path)

func on_camera_change():
	pov = system.active_camera
	camera_view = pov.viewport.get_texture()	
	#$Viewport/Background.texture = camera_view
	screen_material.albedo_texture = camera_view #load("res://BSOD2.jpg")
	#camera_view #$Viewport.get_texture()
	$Cockpit_Mesh.set_material_override(screen_material)
