extends Node

var rng = RandomNumberGenerator.new()
var count = 0
var test_object
var bubble

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	bubble = get_parent()
	test_object = load("res://Test/TestObject.tscn")
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generate_velocity():
	return 5*Vector3(randf(), randf(), randf())

func _on_Timer_timeout():
	count = count+1
	var test_object_instance = test_object.instance()
	add_child(test_object_instance)
	print("Object ", count, " spawned")
