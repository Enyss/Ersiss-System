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
var sim
var earth
var p

var format_string = """Visual:
dx={dx}
dy={dy}
dz={dz}

Simulation :
dx={sim_dx}
dy={sim_dy}
dz={sim_dz}

Error :
Error x={err_dx}
Error y={err_dy}
Error z={err_dx}"""

# Called when the node enters the scene tree for the first time.
func _ready():
	sim = get_node(sim_path)

func _process(delta):
	if earth == null:
		earth = sim.get_node("Earth")
	var p = sim.global_bubble.simbody
	var e = earth.global_transform.origin
	var dp = earth.simbody.position_relative_to(p,1000000)
	self.text = format_string.format({
		"dx": e.x,
		"dy": e.y,
		"dz": e.z,
		"sim_dx": dp.x,
		"sim_dy": dp.y,
		"sim_dz": dp.z,
		"err_dx": dp.x-e.x,
		"err_dy": dp.y-e.y,
		"err_dz": dp.z-e.z,
		})
