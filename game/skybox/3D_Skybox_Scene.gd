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

var celestial_bodies = Array()
var skybox_camera
var local_bubble
var light_source = Vector3()

func _ready():
	local_bubble = get_node("/root/Spaced/Local Bubble")
	skybox_camera = $Skybox_Camera

func _process(_delta):
	var tmp_scale = skybox_camera.scale;
	var target_camera = local_bubble.player_body.get_node("PoV/Camera")
	skybox_camera.global_transform.basis = target_camera.global_transform.basis
	var tmp = local_bubble.player_body.simbody.position /1000000
	skybox_camera.translation = local_bubble.player_body.simbody.position /1000000
	skybox_camera.scale = tmp_scale
	
	light_source = $Sun.transform.origin - skybox_camera.transform.origin
	for body  in celestial_bodies:
		body.transform.origin = body.simbody.position/1000000
	
func add_to_local_objects(object):
	celestial_bodies.append(object)
