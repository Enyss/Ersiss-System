extends Spatial

export (NodePath) var camera_path

# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_material = "res://ship/SimpleShipOne/Cockpit/Screen/screen_texture.tres"
	$bottom_screen.surface_set_material( 0, screen_material )
#	$Viewport/TextureRect.texture = get_node(camera_path)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
