extends Camera


# Called when the node enters the scene tree for the first time.
func _ready():
	var sky := PanoramaSky.new()
	var bg := ($Viewport as Viewport).get_texture() 
	sky.panorama = bg
	environment = Environment.new()
	environment.background_sky = sky
