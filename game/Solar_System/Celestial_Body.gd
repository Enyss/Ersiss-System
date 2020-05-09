extends Spatial
class_name Celestial_Body

#Local scene
var local_scene
export(String, FILE, "*.tscn,*.scn") var local_scene_path 

#setget set_scene_path
#func set_scene_path(p_value):
 #   if typeof(p_value) == TYPE_STRING and p_value.get_extension() in ["tscn", "scn"]:
  #      var d = Directory.new()
   #     if not d.file_exists(p_value):
	#        return
	 #   scene_path = p_value

#Simbody
enum BodyClass { NONE, CELESTIAL, SIMULATED, BUBBLE }
export (BodyClass) var body_class = BodyClass.NONE
var simbody

#Global Position Setup
export (NodePath) var parent_body_path
var children_bodies = Array()
var parent

export (bool) var is_root = false
export (float) var semi_major_axis_in_Gm
export (float,0,360,1) var true_anomaly_in_degree
export (float) var orbital_period_in_days = 365.25
export (float) var mass_in_earth_mass = 1.0

func _init():
	simbody = load("res://bin/orbsim_body.gdns").new()
	
func _exit_tree():
	simbody.queue_free()

func _ready():
	get_node("/root/Main/Global").add_body_to_simulation(self)
	simbody.mass = mass_in_earth_mass
	parent = get_node_or_null(parent_body_path)
	if (parent != null):
		parent.register_child_body(self)

func register_child_body(child):
	children_bodies.append(child)

func set_position():
	if parent == null:
		simbody.position = Vector3(0,0,0)
		simbody.velocity = Vector3(0,0,0)
	else:
		#set position
		var x = semi_major_axis_in_Gm * cos(deg2rad(true_anomaly_in_degree)) 
		var z = semi_major_axis_in_Gm * sin(deg2rad(true_anomaly_in_degree)) 
		var pos = Vector3(x,0,z)
		simbody.set_position_relative_to(parent.simbody,  pos, 1000000000 )
		#set velocity
		var speed_in_ms = (2 * PI * 11574.074) * semi_major_axis_in_Gm / orbital_period_in_days 
		var vx = speed_in_ms * cos(deg2rad(true_anomaly_in_degree-90)) 
		var vz = speed_in_ms * sin(deg2rad(true_anomaly_in_degree-90))
		var v = Vector3(vx,0,vz)
		simbody.set_velocity_relative_to(parent.simbody, v )
	for body in children_bodies:
		if body.is_in_group("Celestial_Body"):
			body.set_position()
