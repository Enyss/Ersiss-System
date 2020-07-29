extends Component

onready var battery_ui = $Viewport/BatteryScreenUI
var active

# Called when the node enters the scene tree for the first time.
func _ready():
	$BatteryScreen.get_surface_material(0).albedo_texture = $Viewport.get_texture()

func _process(_delta):
	return
	battery_ui.max_capacity = system.nominal_capacity
	battery_ui.capacity = system.capacity
	battery_ui.current = system.amperage
	battery_ui.voltage = system.voltage

func set_active(active):
	if active :
		$BatteryScreen.get_surface_material(0).albedo_texture = $Viewport.get_texture()
	else:
		$BatteryScreen.get_surface_material(0).albedo_texture = null
