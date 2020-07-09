extends System

export (bool) var door_is_open : bool = false
var state : String = "can_open"

func _ready():
	pass 

func on_door_button_pressed():
	match state :
		"can_open" :
			state = "opening"
		"can_close" :
			state = "closing"
	emit_signal("updated")

func on_door_close():
	state = "can_open"
	emit_signal("updated")
	
func on_door_open():
	state = "can_close"
	emit_signal("updated")
