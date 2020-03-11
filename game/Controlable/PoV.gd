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
