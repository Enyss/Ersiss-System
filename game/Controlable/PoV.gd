extends Spatial

onready var camera = $Camera
export var current = false
export var yaw_range = 150
export var pitch_range = 150
var yaw_angle = 0
var pitch_angle = 0

var mouse_sensitivity = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#yaw
		var yaw_change = -event.relative.x*mouse_sensitivity
		#if yaw_angle+yaw_change < yaw_range/2 and yaw_angle+yaw_change > - yaw_range/2:
		var axis = camera.global_transform.basis.y
		global_rotate(axis,deg2rad(-event.relative.x*mouse_sensitivity))
		#	yaw_angle += yaw_change		
		#pitch	
		var pitch_change = -event.relative.y*mouse_sensitivity
		if pitch_angle+pitch_change < pitch_range/2  and pitch_angle+pitch_change > -pitch_range/2:
			camera.rotate_x(deg2rad(pitch_change))
			pitch_angle += pitch_change
