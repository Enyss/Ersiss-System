extends KinematicBody
var mouse_sensitivity = 0.3
var camera_angle = 0

export var active = false

var a = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		
func _input_event( _camera,  event,  _click_position,  _click_normal,  _shape_idx ):
	if (event.is_action_pressed("ui_click")):
		var player = get_node("/root/Player")
		player.lock_to(self)
		


func _input(event):
	pass
