extends Switch

func setup()->void:
	self.connect("clicked", system, "on_door_button_pressed")
	system.connect("updated", self, "on_system_update")

func on_system_update()->void:
	update_state(system.state)
