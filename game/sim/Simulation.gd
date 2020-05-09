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

var sim : Sim

var simulation_speed := 1.0
var time :=0.0

var simulated_bodies : Array = Array()
var massive_bodies : Array = Array()
var bubble

func _init():
	sim = Sim.new()

func _physics_process(delta):
	time += simulation_speed*delta
	for _i in range(simulation_speed):
		sim.update(delta)

func add_body(body : Node ) -> void:
	match body.body_class:
		body.BodyClass.CELESTIAL:
			massive_bodies.push_back(body)
			sim.add_celestial_body(body.simbody)
		body.BodyClass.SIMULATED:
			simulated_bodies.push_back(body)
			sim.add_simulated_body(body.simbody)
		body.BodyClass.BUBBLE:
			bubble = body
			sim.add_simulated_body(body.simbody)
			
func remove_body_from_simulation(body : Node):
	print("remove_body_from_simulation not yet implemented")
