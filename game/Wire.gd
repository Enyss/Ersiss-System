extends Area

signal power(voltage,component)

var A = 0
var amperage_supplied = 0
var voltage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _physics_process(delta):
	A = amperage_supplied
	amperage_supplied = 0
	emit_signal("power",voltage, self)

func _on_Battery_power(v, component):
	voltage = v
	component.draw_power(amperage_supplied)

func draw_power(a):
	amperage_supplied += a
