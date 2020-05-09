extends Node
class_name Controller

export (bool) var active := false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Controller")
	set_process(false)
	set_process_input(false)

func activate():
	pass
	
func desactivate():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
