extends "res://3DControls/Switch/Switch.gd"

var button_states = [{"text":"BAT 1", "color":Color.lightgray},
	{"text":"BAT 1", "color":Color.green},
	{"text":"BAT 1", "color":Color.yellow},
	{"text":"BAT 1", "color":Color.red},
	]
	
func _init():
	states = button_states
