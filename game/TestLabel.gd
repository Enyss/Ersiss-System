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

var msg = """Battery :
	Voltage (V) : {v}
	Capacity (Ah) : {Ah}

Wire :
	Voltage (V) : {v2}
	Amperage (A) : {A}

Pump :
	{active}"""

var battery
var pump
var wire

# Called when the node enters the scene tree for the first time.
func _ready():
	battery = get_node("../Battery")
	pump = get_node("../Pump")
	wire = get_node("../Wire")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = msg.format( {
		"v":battery.voltage,
		"Ah":battery.capacity,
		"v2":wire.voltage,
		"A":wire.A,
		"active": ("Active" if pump.powered else "Inactive"),
	})

func _physics_process(delta):
	print("tick")
	
