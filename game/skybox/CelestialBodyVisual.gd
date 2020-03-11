extends Spatial

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(_delta):
	if player==null:
		player = get_parent().player
	transform.origin = player.simbody.position/1000000
