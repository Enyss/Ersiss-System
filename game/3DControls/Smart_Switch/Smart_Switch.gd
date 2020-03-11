extends KinematicBody

signal changed(pressed)
export var pressed = false

var state = 0
var states = [{"text":"START", "color":Color.green},
	{"text":"STARTING", "color":Color.yellow},
	{"text":"RUNNING", "color":Color.green},
	{"text":"STOPPING", "color":Color.yellow},
	{"text":"WARNING", "color":Color.orange},
	{"text":"ERROR", "color":Color.red},
	]
var audio

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("changed",pressed)
	audio = get_node("AudioPlay")

func _input_event( _camera,  event,  _click_position,  _click_normal,  _shape_idx ):
	if (event.is_action_pressed("ui_click")):
		pressed = !pressed
		move_button()
		emit_signal("changed",pressed)

func update_state(new_state):
	state = new_state
	update_text(states[state])

func update_text(s):
	var label = get_node("Viewport/Label")
	label.text = s.text
	label.add_color_override("font_color", states[state].color)
	get_node("Viewport/Outline").color = states[state].color

func reset():
	pressed = false
	move_button()
	

func move_button():
	if pressed :
		get_node("Button").transform.origin = Vector3(0,-0.03,0)
	else:
		get_node("Button").transform.origin = Vector3(0,0.05,0)
	audio.play()
