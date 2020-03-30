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

extends Node

var base_controller_path = "Simulation/LocalBubble/Player_Body/Control"
onready var pov = $Camera

var base_controller
var controller

var looking_at = null

# Called when the node enters the scene tree for the first time.
func _ready():
	#create the background camera
	get_tree().call_group("PoV","create_background_camera")
	#set the active controller
	base_controller = get_node(base_controller_path)
	controller = base_controller
	controller.activate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	looking_at = pov.looking_at()
	if (looking_at!=null):
		if Input.is_action_just_pressed("ui_click"):
			looking_at.click()

func set_controller(new_controller):
	#If the controller don't change
	if (new_controller == controller):
		return;
	
	#If the controller change
	controller.desactivate()
	if (new_controller == null):
		controller = base_controller
	else:
		controller = new_controller
	controller.activate()

func reset_controller( position ):
	set_controller(base_controller)
	controller.set_movement(position, $Simulation/LocalBubble.anchor )
