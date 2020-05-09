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

onready var pov = $Camera

var base_controller : Controller
var controller : Controller

var looking_at : Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	#create the background camera
	get_tree().call_group("PoV","create_background_camera")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	looking_at = pov.looking_at()
	if (looking_at!=null):
		if Input.is_action_just_pressed("ui_click"):
			looking_at.click()


func set_base_controller() -> void:
	var controllers = get_tree().get_nodes_in_group("Controller")
	for c in controllers:
		if c.active :
			base_controller = c
			set_controller(c)
			return

func set_controller(new_controller : Controller) -> void:
	#If the controller don't change
	if (new_controller == controller):
		return;
	#If the controller change
	if (controller != null):
		controller.desactivate()
	if (new_controller == null):
		controller = base_controller
	else:
		controller = new_controller
	controller.activate()

func reset_controller( position : Vector3) -> void:
	set_controller(base_controller)
#	controller.set_movement(position, $Simulation/LocalBubble.anchor )
