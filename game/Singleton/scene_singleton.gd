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

var center : Simbody setget , get_center
var anchor : OrbitalBody setget set_anchor, get_anchor

var max_distance = 100
var local_objects := Array()

var pov_background = preload("res://Camera/PoV_Background.tscn")
var povs := Array()

func set_center(body : Simbody) -> void :
	center = body
func get_center() -> Simbody :
	return center
func set_anchor(body : OrbitalBody) -> void :
	anchor = body
func get_anchor() -> OrbitalBody :
	return anchor
	

func _physics_process(delta):
	if anchor != null && center.distance_to(anchor.simbody) > max_distance:
			center_bubble()
	
func initialize() -> void:
	Player.reset_controller()
	for object in local_objects:
		object.simbody.set_position_relative_to(center, object.transform.origin)
		object.simbody.set_velocity_relative_to(center, object.velocity )

func add_to_local_objects(object):
	local_objects.append(object)

func center_bubble():
	center.set_position_relative_to(anchor.simbody, Vector3() )	
	center.set_velocity_relative_to(anchor.simbody, Vector3() )	
	for object in local_objects:
		object.transform.origin = object.simbody.position_relative_to(center)
		
func add_pov(pov : Node ) -> PovBackground :
	var b : PovBackground = pov_background.instance()
	b.setup(pov)
	get_node("/root/Main/Global").add_child(b)
	return b
