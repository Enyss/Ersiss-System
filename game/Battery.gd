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

extends Area

signal power(voltage,component)
var power_supplied
export (float) var nominal_voltage
export (float) var nominal_capacity
var voltage
var amperage
var capacity

# Called when the node enters the scene tree for the first time.
func _ready():
	amperage = 0
	voltage = nominal_voltage
	capacity = nominal_capacity
	
func _physics_process(delta):
	capacity -= (amperage*delta)/3600
	voltage = compute_voltage()
	amperage = 0
	emit_signal("power",voltage,self)
	
func compute_voltage():
	var v
	var normalized_capacity = capacity/nominal_capacity * 100
	if normalized_capacity > 10 :
		v = nominal_voltage * (0.9+normalized_capacity/1000)
	else:
		v = 0.9*nominal_voltage*exp(-10/normalized_capacity)
	return v

func draw_power(a):
	amperage += a
