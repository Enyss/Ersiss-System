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

extends OrbitalBody

export (NodePath) var parent_body_path
var children_bodies = Array()
var parent

export (bool) var is_root = false
export (float) var semi_major_axis_in_Gm
export (float,0,360,1) var true_anomaly_in_degree
export (float) var orbital_period_in_days = 365.25
export (float) var mass_in_earth_mass = 1.0

func _ready():
	simbody.mass = mass_in_earth_mass
	parent = get_node_or_null(parent_body_path)
	if (parent != null):
		parent.register_child_body(self)

func register_child_body(child):
	children_bodies.append(child)

func set_position():
	if parent == null:
		simbody.position = Vector3(0,0,0)
		simbody.velocity = Vector3(0,0,0)
	else:
		#set position
		var x = semi_major_axis_in_Gm * cos(deg2rad(true_anomaly_in_degree)) 
		var z = semi_major_axis_in_Gm * sin(deg2rad(true_anomaly_in_degree)) 
		var pos = Vector3(x,0,z)
		simbody.set_position_relative_to_scaled(parent.simbody,  pos, 1000000000 )
		#set velocity
		var speed_in_ms = (2 * PI * 11574.074) * semi_major_axis_in_Gm / orbital_period_in_days 
		var vx = speed_in_ms * cos(deg2rad(true_anomaly_in_degree-90)) 
		var vz = speed_in_ms * sin(deg2rad(true_anomaly_in_degree-90))
		var v = Vector3(vx,0,vz)
		simbody.set_velocity_relative_to(parent.simbody, v )
	for body in children_bodies:
		if body.is_in_group("Celestial_Body"):
			body.set_position()
