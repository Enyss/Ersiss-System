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
	
