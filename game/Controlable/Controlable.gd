extends Node

var active = false
	
func _ready():
	set_process(active)

func set_active():
	active = true
	set_process(active)

func set_inactive():
	active = false
	set_process(active)
