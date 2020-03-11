extends KinematicBody

var mouse_sensitivity = 0.3
var camera_angle = 0
var acceleration = 1.0

export var massive : bool
export var mass : float
export var simulated : bool
export var position_in_km : Vector3
export var velocity : Vector3

var a = Vector3()
var simbody
var locked_to

# Called when the node enters the scene tree for the first time.
func _ready():
	simbody = load("res://bin/orbsim_body.gdns").new()
	simbody.mass = mass
	simbody.position = position_in_km * 1000
	simbody.velocity = velocity
	get_node("/root/OrbitalSimulation").register_body(self)
		
func _exit_tree():
	simbody.queue_free()

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var axis = $Camera.global_transform.basis.y
		global_rotate(axis,deg2rad(-event.relative.x*mouse_sensitivity))		
		var change = -event.relative.y*mouse_sensitivity
		if camera_angle+change<75 and camera_angle+change>-75:
			$Camera.rotate_x(deg2rad(change))
			camera_angle += change
		else:
			axis = $Camera.global_transform.basis.x
			global_rotate(axis,deg2rad(change))
			
func _process(delta):
	a = Vector3()
	if Input.is_action_pressed("move_forward"):
		a-= $Camera.global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		a+= $Camera.global_transform.basis.z
	if Input.is_action_pressed("move_up"):
		a+= $Camera.global_transform.basis.y
	if Input.is_action_pressed("move_down"):
		a-= $Camera.global_transform.basis.y
	if Input.is_action_pressed("move_left"):
		a-= $Camera.global_transform.basis.x
	if Input.is_action_pressed("move_right"):
		a+= $Camera.global_transform.basis.x
	if Input.is_action_pressed("roll_clockwise"):
		var axis = $Camera.global_transform.basis.z
		global_rotate(axis, -PI/4*delta)
	if Input.is_action_pressed("roll_counterclockwise"):
		var axis = $Camera.global_transform.basis.z
		global_rotate(axis, +PI/4*delta)
	a = a.normalized()
	simbody.acceleration = a * acceleration
	
func lock_to(node):
	locked_to = node
	
