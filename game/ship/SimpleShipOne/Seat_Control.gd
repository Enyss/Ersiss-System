extends Node

var mouse_sensitivity = 0.3
var cam
var head

func _ready():
	cam = get_node("../PoV/Camera")
	head = get_node("../PoV")

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_node("/root/Spaced/Player").change_body(null)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var yaw_change = -event.relative.x*mouse_sensitivity
		#if yaw_angle+yaw_change < yaw_range/2 and yaw_angle+yaw_change > - yaw_range/2:
		#var axis = $Camera.global_transform.basis.y
		cam.rotate_y(deg2rad(yaw_change))
		#	yaw_angle += yaw_change		
		#pitch	
		var pitch_change = -event.relative.y*mouse_sensitivity
		#axis = $Camera.global_transform.basis.x
		#if pitch_angle+pitch_change < pitch_range/2  and pitch_angle+pitch_change > -pitch_range/2:
		head.rotate_z(deg2rad(pitch_change))
		#	pitch_angle += pitch_change
		#else :
		#	axis = camera.global_transform.basis.x
		#	global_rotate(axis,deg2rad(-pitch_change))
		
