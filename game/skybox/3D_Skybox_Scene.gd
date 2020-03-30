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

export (NodePath) var root_body_path
export (NodePath) var local_bubble_path
var local_bubble
var global_bubble

var povs = Dictionary()
var pov_background
var time = 0

var light_source
var light_direction = Vector3()

func _init():
	pov_background = preload("res://Camera/PoV_Background.tscn")

func _ready():
	local_bubble = get_node(local_bubble_path)
	global_bubble = $Settings.get_global_bubble()
	
	celestial_bodies = get_tree().get_nodes_in_group("Celestial_Body")
	
	get_node(root_body_path).set_position()
	global_bubble.set_simbody() 
		
	light_source = $Settings.get_light_source()


func _process(_delta):
	#camera synchro
	
	#for camera in cameras.keys():
	#	cameras[camera].global_transform.basis = camera.global_transform.basis
	#	cameras[camera].global_transform.origin = camera.get_global_position()
		
	#var tmp_scale = global_bubble.scale;
	#var target_camera = local_bubble.player_body.get_node("PoV/Camera")
#	global_bubble.global_transform.basis = target_camera.global_transform.basis
#	global_bubble.scale = tmp_scale
	
	#update celestial bodies position
	global_bubble.global_transform.origin = Vector3()
	for body in celestial_bodies:
		var p = body.simbody.position_relative_to(local_bubble.anchor,1000000)
		body.global_transform.origin = p
	
	#update light
	light_direction = -light_source.global_transform.origin
	
func add_pov(pov):
	var b = pov_background.instance()
	b.pov = pov
	povs[pov] = b
	add_child(b)
	return b

func add_to_local_objects(object):
	celestial_bodies.append(object)
