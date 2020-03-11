extends Spatial

export var position_in_Mm = Vector3()
export var mass_in_earth_mass = 1.0
var simbody

func _ready():
	simbody = $SimBody.simbody
	simbody.position = position_in_Mm * 1000000
	simbody.mass = mass_in_earth_mass
