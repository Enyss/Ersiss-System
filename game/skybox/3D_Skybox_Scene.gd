extends Spatial

var celestial_bodies = Array()
var skybox_camera
var local_bubble
var light_source = Vector3()

func _ready():
	local_bubble = get_node("/root/Spaced/Local Bubble")
	skybox_camera = $Skybox_Camera

func _process(_delta):
	var tmp_scale = skybox_camera.scale;
	var target_camera = local_bubble.player_body.get_node("PoV/Camera")
	skybox_camera.global_transform.basis = target_camera.global_transform.basis
	var tmp = local_bubble.player_body.simbody.position /1000000
	skybox_camera.translation = local_bubble.player_body.simbody.position /1000000
	skybox_camera.scale = tmp_scale
	
	light_source = $Sun.transform.origin - skybox_camera.transform.origin
	for body  in celestial_bodies:
		body.transform.origin = body.simbody.position/1000000
	
func add_to_local_objects(object):
	celestial_bodies.append(object)
