extends OrbitalBody

export (NodePath) var parent_body_path
export (float) var altitude_in_km = 7000
export (float,0,360,1) var true_anomaly_in_degree
export (float) var speed_in_ms = 7700

func set_simbody():
	var parent = get_node(parent_body_path).simbody
	#set position
	var x = altitude_in_km * cos(deg2rad(true_anomaly_in_degree))
	var z = altitude_in_km * sin(deg2rad(true_anomaly_in_degree))
	var pos = Vector3(x,0,z)
	simbody.set_position_relative_to_scaled(parent, pos, 1000)
	
	#set velocity
	var vx = speed_in_ms * cos(deg2rad(true_anomaly_in_degree-90)) 
	var vz = speed_in_ms * sin(deg2rad(true_anomaly_in_degree-90))
	var v = Vector3(vx,0,vz)
	simbody.set_velocity_relative_to(parent, v)
