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

extends Label

var earth : Node
var bubble : Node

const format_string = """FPS : {fps}
Simulation speed : {speed}x

Position (km) : {h}
	{pos}
Velocity (m/s) : {v} 
	{vel}"""

# Called when the node enters the scene tree for the first time.
func _ready():
	bubble = get_node("/root/Main/Local")

func _process(_delta):
	if earth == null:
		earth = get_node("/root/Main/Global/Earth")
	if bubble.anchor == null:
		return
	var e = earth.simbody
	var a = bubble.anchor.simbody
	var pos = e.position_relative_to_scaled(a,1000)
	var vel = e.velocity_relative_to(a)
	self.text = format_string.format({
		"fps":Engine.get_frames_per_second(),
		"speed" : Simulation.simulation_speed,
		"h" : "%.4f" % pos.length(),
		"pos" : "(%.f , %.f, %.f)" % [pos.x,pos.y,pos.z],
		"v" : "%.4f" % vel.length(),
		"vel" : "(%.f , %.f, %.f)" % [vel.x,vel.y,vel.z],		
		})
