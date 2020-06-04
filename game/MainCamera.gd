extends Camera

var global_camera
onready var camera = self
var background

var zoom = 0
onready var raycast = $RayCast


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("PoV")
	setup_camera()
	Player.pov = self
	
func _process(_delta):
	var target = raycast.get_collider()
	Player.looking_at = target
	if Input.is_action_just_pressed("ui_click"):
		if target != null && target.has_method("click"):
			target.click()
	if Input.is_action_just_pressed("fps_zoom"):
		zoom += 1
		if zoom == 2:
			zoom = 0
		fov = 70-30*zoom

func setup_camera():
	camera.fov = fov
	global_camera = Scene.add_pov(self)
	#global_camera.camera.fov = camera.fov
	background = $Background/texture
	background.texture = global_camera.get_texture()
	global_camera.size = get_node("/root").size
