extends Label

var format_string = """FPS : {fps}
Simulation Speed : {s}x
Time elapsed : {t} s

v={v}
h={h}

x={x}
y={y}
z={z}

vx={vx}
vy={vy}
vz={vz}"""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	var sim = get_node("/root/Spaced/Simulation")
	var simbody = get_node("/root/Spaced/Local Bubble").player_body.simbody
	self.text = format_string.format({
		"fps": 0 if delta==0 else 1/delta,
		"s": sim.simulation_speed,
		"t": sim.time,
		"v": simbody.velocity.length(),
		"h": simbody.position.length(),
		"x": simbody.position.x,
		"y": simbody.position.y,
		"z": simbody.position.z,
		"vx": simbody.velocity.x,
		"vy": simbody.velocity.y,
		"vz": simbody.velocity.z,
		})
