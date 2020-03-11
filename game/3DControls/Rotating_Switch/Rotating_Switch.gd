extends KinematicBody

signal changed(index)
export var index = 0
export var positions = 6
var knob
var audio

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("changed",index)
	knob = get_node("Knob")
	audio = get_node("AudioPlay")

func _input_event( _camera,  event,  _click_position,  _click_normal,  _shape_idx ):
	if (event.is_action_pressed("ui_click")):
		index = (index+1)%positions
		knob.rotate_y(2*PI/positions)
		audio.play()
		emit_signal("changed",index)
	if (event.is_action_pressed("ui_click_alt")):
		index = (index+positions-1)%positions
		knob.rotate_y(-2*PI/positions)
		audio.play()
		emit_signal("changed",index)
