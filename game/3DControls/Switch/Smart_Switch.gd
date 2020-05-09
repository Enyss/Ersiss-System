# Copyright (c) 2020 The Eriss-System Project Contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

extends Component

signal changed(button)
export var pressed = false

var state = 0
export var states = [{"text":"START", "color":Color.green},
	{"text":"STARTING", "color":Color.yellow},
	{"text":"RUNNING", "color":Color.green},
	{"text":"STOPPING", "color":Color.yellow},
	{"text":"WARNING", "color":Color.orange},
	{"text":"ERROR", "color":Color.red},
	]
var audio


func _ready():
	emit_signal("changed",self)
	audio = get_node("AudioPlay")

func _input_event( _camera,  event,  _click_position,  _click_normal,  _shape_idx ):
	if (event.is_action_pressed("ui_click")):
		pressed = !pressed
		move_button()
		emit_signal("changed",self)

func click():
	pressed = !pressed
	move_button()
	emit_signal("changed",self)

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
