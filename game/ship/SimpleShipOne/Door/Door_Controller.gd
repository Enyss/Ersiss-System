extends Spatial

var open = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Smart_Switch_changed(button):
	if (open):
		$AnimationPlayer.play("Close_Door")
		open = false
	else:
		$AnimationPlayer.play("Open_Door")
		open = true

func _on_AnimationPlayer_animation_finished(anim_name):
	pass # Replace with function body.
