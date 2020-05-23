extends System

signal camera_changed()

var cameras : Dictionary
var active_camera
	
func register_component(component):
	.register_component(component)
	if component is Pov:
		cameras[component.component_name] = component

func initialize():
	for component in components.values() :
		component.setup()
		
	set_active_camera("front_camera")

func set_active_camera(camera_name):
	active_camera = cameras[camera_name]
	emit_signal("camera_changed")
	
func next_camera(node):
	if active_camera.component_name == "front_camera":
		set_active_camera("back_camera")
	else:
		set_active_camera("front_camera")
	
