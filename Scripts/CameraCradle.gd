extends Node3D

@export var speed:float = 20

var input_dir:Vector3

func _process(delta):
	
	input_dir = Vector3(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down"),
		0
	)
	  
	translate(input_dir.normalized() * speed * delta)
