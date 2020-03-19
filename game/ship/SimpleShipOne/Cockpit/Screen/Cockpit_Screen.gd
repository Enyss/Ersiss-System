extends Spatial

var screen_material
export (NodePath) var pov_path
var pov
var camera_view

# Called when the node enters the scene tree for the first time.
func _ready():
	var p = "res://ship/SimpleShipOne/Cockpit/Screen/new_spatialmaterial.tres"
	screen_material = load(p)
	pov = get_node(pov_path)
	camera_view = pov.viewport.get_texture()	
	#$Viewport/Background.texture = camera_view
	screen_material.albedo_texture = camera_view #$Viewport.get_texture()
	$Cockpit_Mesh.set_material_override(screen_material)
