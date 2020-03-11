extends Node

var engine_states = ["off", "starting", "running", "stopping", "warning" ,"error"]
var engine_state = 0
var engine_power = 0

# Called when the node enters the scene tree for the first time.
func _ready():	
	get_node("Smart_Switch_1").update_state(engine_state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Smart_Switch_1_changed(pressed):
	if pressed:
		start_engine()
	else:
		stop_engine()
	get_node("Smart_Switch_1").update_state(engine_state)


func _on_Rotating_switch_1_changed(index):
	get_node("OmniLight").light_energy = index/3.0


func _on_Rotating_switch_2_changed(index):
	engine_power = index

func start_engine():
	if engine_state==0:
		engine_state = 1
		var timer = get_node("Engine_Startup_Timer")
		timer.set_wait_time(4)
		timer.start()
		timer.connect("timeout", self, "_on_engine_started")

func stop_engine():
	match engine_state:
		1,2,4,5:
			engine_state = 3
			var timer = get_node("Engine_Stopping_Timer")
			timer.set_wait_time(3)
			timer.start()
			timer.connect("timeout", self, "_on_engine_stopped")
			

func _on_engine_started():
	engine_state = 2
	get_node("Smart_Switch_1").update_state(engine_state)


func _on_engine_stopped():
	engine_state = 0
	get_node("Smart_Switch_1").update_state(engine_state)
	
