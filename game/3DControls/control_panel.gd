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

var engine_states = ["off", "starting", "running", "stopping", "warning" ,"error"]
var engine_state = 0
var engine_power = 0

# Called when the node enters the scene tree for the first time.
func _ready():	
	get_node("Smart_Switch_1").update_state(engine_state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Smart_Switch_1_changed(pressed):
	if pressed:
		start_engine()
	else:
		stop_engine()
	get_node("Smart_Switch_1").update_state(engine_state)


func _on_Rotating_switch_1_changed(index):
	get_node("OmniLight").light_energy = index/3.0


func _on_Rotating_switch_2_changed(index):
	engine_power = index

func start_engine():
	if engine_state==0:
		engine_state = 1
		var timer = get_node("Engine_Startup_Timer")
		timer.set_wait_time(4)
		timer.start()
		timer.connect("timeout", self, "_on_engine_started")

func stop_engine():
	match engine_state:
		1,2,4,5:
			engine_state = 3
			var timer = get_node("Engine_Stopping_Timer")
			timer.set_wait_time(3)
			timer.start()
			timer.connect("timeout", self, "_on_engine_stopped")
			

func _on_engine_started():
	engine_state = 2
	get_node("Smart_Switch_1").update_state(engine_state)


func _on_engine_stopped():
	engine_state = 0
	get_node("Smart_Switch_1").update_state(engine_state)
	
