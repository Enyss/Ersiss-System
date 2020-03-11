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

extends "res://sim/Physical_Body.gd"

#Bodies in Local Scene
export (NodePath) var starting_body_path

var center
var player_body
var local_objects = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	center = simbody
	player_body = get_node(starting_body_path)
	player_body.set_active()
	player_body.set_controlled()
	_on_Center_Local_Bubble_timeout()
	pass # Replace with function body.

func add_to_local_objects(object):
	local_objects.append(object)

func _on_Center_Local_Bubble_timeout():
	center.set_position_relative_to(player_body.simbody, Vector3() )	
	center.set_velocity_relative_to(player_body.simbody, Vector3() )	
	for object in local_objects:
		object.transform.origin = object.simbody.position_relative_to(center)
