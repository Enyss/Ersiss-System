extends Switch


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setup():
	system.connect("camera_changed", self, "on_camera_changed")
	connect("clicked", system, "next_camera")

func on_camera_changed():
	reset()
	update_state(system.active_camera.component_name)
