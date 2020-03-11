extends "res://Controlable/Controlable.gd"

var acceleration = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var a = Vector3()
	var basis = get_node("../PoV/Camera").global_transform.basis
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
		get_parent().global_rotate(basis.z, -PI/4*delta)
	if Input.is_action_pressed("roll_counterclockwise"):
		get_parent().global_rotate(basis.z, +PI/4*delta)
	get_parent().base_acceleration = a.normalized()*acceleration
