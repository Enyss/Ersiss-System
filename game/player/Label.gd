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

export (NodePath) var sim_path
var earth
var bubble

var format_string = """FPS : {fps}
Simulation speed : {speed}x

Position (km) : {h}
	{pos}
Velocity (m/s) : {v} 
	{vel}"""

# Called when the node enters the scene tree for the first time.
func _ready():
	bubble = get_node("/root/Spaced/Player/Simulation/LocalBubble")

func _process(delta):
	if earth == null:
		earth = get_node(sim_path).get_node("Earth")
	var pos = earth.simbody.position_relative_to(bubble.anchor,1000)
	var vel = earth.simbody.velocity_relative_to(bubble.anchor,1)
	self.text = format_string.format({
		"fps":Engine.get_frames_per_second(),
		"speed" : get_node("/root/Spaced/Player/Simulation").simulation_speed,
		"h" : "%.4f" % pos.length(),
		"pos" : "(%.f , %.f, %.f)" % [pos.x,pos.y,pos.z],
		"v" : "%.4f" % vel.length(),
		"vel" : "(%.f , %.f, %.f)" % [vel.x,vel.y,vel.z],		
		})
