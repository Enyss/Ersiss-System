extends Spatial

export(NodePath) var battery_path
var battery
var battery_ui

var active

# Called when the node enters the scene tree for the first time.
func _ready():
	battery = get_node(battery_path)
	battery_ui = $Viewport/VBoxContainer
	$BatteryScreen.get_surface_material(0).albedo_texture = $Viewport.get_texture()

func _process(delta):
	battery_ui.max_capacity = battery.nominal_capacity
	battery_ui.capacity = battery.capacity
	battery_ui.current = battery.amperage
	battery_ui.voltage = battery.voltage

func set_active(active):
	if active :
		$BatteryScreen.get_surface_material(0).albedo_texture = $Viewport.get_texture()
	else:
		$BatteryScreen.get_surface_material(0).albedo_texture = null

func _on_Smart_Switch_changed(button):
	if (button.pressed):
		set_active(true)
		if battery.capacity/battery.nominal_capacity < 0.01:
			button.update_state(3)
		elif battery.capacity/battery.nominal_capacity < 0.1:
			button.update_state(2)
		else:
			button.update_state(1)
	else:
		set_active(false)
		button.update_state(0)
