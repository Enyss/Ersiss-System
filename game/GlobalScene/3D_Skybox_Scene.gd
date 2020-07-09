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

extends Viewport

var celestial_bodies := Array()
onready var global_bubble : OrbitalBody = $Local_Bubble

var pov_background : PackedScene = preload("res://Camera/PoV_Background.tscn")

func _ready():
	celestial_bodies = get_tree().get_nodes_in_group("Celestial_Body")
	for body in celestial_bodies:
		if body.is_root :
			body.set_position()
	global_bubble.set_simbody()

func _process(_delta):	
	#update celestial bodies position
	global_bubble.global_transform.origin = Vector3()
	for body in celestial_bodies:
		var p = body.simbody.position_relative_to_scaled(global_bubble.simbody,1000000)
		body.global_transform.origin = p
	
	#update light
	#light_direction = -light_source.global_transform.origin

func add_to_local_objects(object : OrbitalBody) -> void:
	celestial_bodies.append(object)
