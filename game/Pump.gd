extends Area

export (float) var power_consumption_per_second
export (float) var minimal_voltage
var powered = false
var power_consumption = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if powered:
		power_consumption = power_consumption_per_second
	else:
		power_consumption = 0

func _on_Wire_power(voltage, component):
	var a = 0
	if voltage > minimal_voltage:
		a = power_consumption/voltage
		powered = true
	else:
		powered = false
	component.draw_power(a)
