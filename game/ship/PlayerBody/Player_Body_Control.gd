extends "res://Controller.gd"

var parent
var camera
var acceleration = 1.0
var sensibility = 0.3
# Called when the node enters the scene tree for the first time.

func activate():
	set_process(true)
	set_process_input(true)
	parent = get_parent()
	parent.activate()
	camera = get_node("/root/Spaced/Player").pov
	
func desactivate():
	set_process(false)
	set_process_input(false)
	get_parent().desactivate()
	
func set_movement(position, anchor):
	var center = parent.get_parent().center
	var v = anchor.velocity_relative_to(center)
	parent.simbody.set_position_relative_to(center, position,1)
	parent.simbody.set_velocity_relative_to(center, v)


func _input(e):
	if e is InputEventMouseMotion:
		var basis = parent.global_transform.basis
		#print(basis.x, basis.y)
		parent.global_rotate(basis.x.normalized(), -e.relative.y * sensibility/60)
		parent.global_rotate(basis.y.normalized(), -e.relative.x * sensibility/60)

func _process(delta):
	var a = Vector3()	
	var basis = parent.global_transform.basis
	if Input.is_action_pressed("move_forward"):
		a-= basis.z
	if Input.is_action_pressed("move_back"):
		a+= basis.z
	if Input.is_action_pressed("move_up"):
		a+= basis.y
	if Input.is_action_pressed("move_down"):
		a-= basis.y
	if Input.is_action_pressed("move_left"):
		a-= basis.x
	if Input.is_action_pressed("move_right"):
		a+= basis.x
	if Input.is_action_pressed("roll_clockwise"):
		parent.global_rotate(basis.z, -PI/4*delta)
	if Input.is_action_pressed("roll_counterclockwise"):
		parent.global_rotate(basis.z, +PI/4*delta)
	get_parent().base_acceleration = a.normalized()*acceleration
	
	camera.global_transform = get_parent().global_transform
