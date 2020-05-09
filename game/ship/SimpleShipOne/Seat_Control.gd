extends Controller

var sensibility = 0.3
var camera

var angle
onready var base_anchor = $Camera_position
onready var anchor = $Camera_position/Anchor

export (NodePath) var ship_path
var ship
var ship_rotation

func activate():
	set_process(true)
	set_process_input(true)
	get_parent().input_ray_pickable = false
	camera = get_node("/root/Main/Player").pov
	angle = Vector2()
	
	ship = get_node(ship_path)
	ship_rotation = ship.get_node("Ship")
	get_tree().call_group("Bubble", "set_bubble_anchor", ship.simbody)
	
func desactivate():
	get_parent().input_ray_pickable = true
	set_process(false)
	set_process_input(false)

func _input(e):
	if e is InputEventMouseMotion:
		angle += e.relative * sensibility/60
		var basis = base_anchor.global_transform.basis
		anchor.global_transform.basis = basis
		anchor.rotate_x(-angle.y)
		anchor.rotate_y(-angle.x)

func _process(delta):		
	#manage input
	var acceleration = 100
	var rotation_speed = 0.5
	var a = Vector3()
	

	var basis = ship.global_transform.basis

	#translation
	if Input.is_action_pressed("ship_translate_forward"):
		a+= basis.y
	if Input.is_action_pressed("ship_translate_back"):
		a-= basis.y
	if Input.is_action_pressed("ship_translate_left"):
		a-= basis.z
	if Input.is_action_pressed("ship_translate_right"):
		a+= basis.z
	if Input.is_action_pressed("ship_translate_up"):
		a-= basis.x
	if Input.is_action_pressed("ship_translate_down"):
		a+= basis.x
	ship.simbody.acceleration = a.normalized()*acceleration
	print(ship.simbody.acceleration)
		
	#rotation
	var alpha = delta*rotation_speed
	if Input.is_action_pressed("ship_rotate_up"):
		ship.rotate(basis.z, alpha)
	if Input.is_action_pressed("ship_rotate_down"):
		ship.rotate(basis.z, -alpha)
	if Input.is_action_pressed("ship_rotate_left"):
		ship.rotate(basis.x, -alpha)
	if Input.is_action_pressed("ship_rotate_right"):
		ship.rotate(basis.x, alpha)
	if Input.is_action_pressed("ship_rotate_clockwise"):
		ship.rotate(basis.y, alpha)
	if Input.is_action_pressed("ship_rotate_counterclockwise"):
		ship.rotate(basis.y, -alpha)
	
	#Update camera position
	camera.global_transform = anchor.global_transform
	
	#Leave the Seat
	if Input.is_action_pressed("leave_seat"):
		get_node("/root/Spaced/Player").reset_controller($Spawn_point.global_transform.origin)
