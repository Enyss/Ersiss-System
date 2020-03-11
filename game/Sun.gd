extends DirectionalLight


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	look_at(get_node("/root/Spaced/Global_Viewport/Global_Scene").light_source, Vector3())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
