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
class_name Switch
#tool 

signal clicked(component)

onready var audio : AudioStreamPlayer3D = $PressSound

var states : Dictionary
var current_state : SwitchData
export (bool) var pressed : bool = false

func _ready():
	#set the button texture
	$Button/Text.get_surface_material(0).albedo_texture = $Texture.get_texture()
	#get the different switch states	
	var children = get_children()
	for child in children:
		if child is SwitchData:
			states[child.state] = child
	#move the button in starting position
	move_button()

func _get_configuration_warning():
	var children = get_children()
	for child in children:
		if child is SwitchData:
			return ""
	return "Missing Switch Data !"
	
func click():
	pressed = !pressed
	move_button()
	emit_signal("clicked",self)

func update_state(state : String) -> void:
	var label = get_node("Texture/Label")
	label.text = states[state].text
	label.add_color_override("font_color", states[state].font_color)
	get_node("Texture/Outline").color = states[state].color

func reset():
	pressed = false
	move_button()

func move_button():
	if pressed :
		$Button.transform.origin = Vector3(0,-0.03,0)
	else:
		$Button.transform.origin = Vector3(0,0.05,0)
	audio.play()
