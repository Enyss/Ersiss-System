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

var format_string = """FPS : {fps}
Simulation Speed : {s}x
Time elapsed : {t} s

v={v}
h={h}

x={x}
y={y}
z={z}

vx={vx}
vy={vy}
vz={vz}"""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	var sim = get_node("/root/Spaced/Simulation")
	var simbody = get_node("/root/Spaced/Local Bubble").player_body.simbody
	self.text = format_string.format({
		"fps": 0 if delta==0 else 1/delta,
		"s": sim.simulation_speed,
		"t": sim.time,
		"v": simbody.velocity.length(),
		"h": simbody.position.length(),
		"x": simbody.position.x,
		"y": simbody.position.y,
		"z": simbody.position.z,
		"vx": simbody.velocity.x,
		"vy": simbody.velocity.y,
		"vz": simbody.velocity.z,
		})
