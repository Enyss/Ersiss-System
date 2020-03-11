extends Spatial

var simbody
var player_simbody

# Called when the node enters the scene tree for the first time.
func _ready():
	simbody = get_node("SimBody")
	player_simbody = get_node("../../Player/SimBody")

func _process(delta):
	transform.origin = simbody.simbody.position_relative_to(player_simbody.simbody)
