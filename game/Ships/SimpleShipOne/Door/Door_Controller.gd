extends Component

signal door_close()
signal door_open()

var open : bool
var moving : bool = false

func setup()->void:
	self.connect("door_close", system, "on_door_close")
	self.connect("door_open", system, "on_door_open")
	system.connect("updated", self, "on_system_update")

func on_system_update()->void:
	match system.state:
		"opening":
			if !moving:
				$AnimationPlayer.play("Open_Door")
				moving = true
		"closing": 
			if !moving:
				$AnimationPlayer.play("Close_Door")
				moving = true

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Open_Door":
			moving=false
			emit_signal("door_open")
		"Close_Door":
			moving=false
			emit_signal("door_close")
			
