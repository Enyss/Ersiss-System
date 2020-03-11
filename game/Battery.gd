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
