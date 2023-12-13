extends Node3D

@export var Rotation:Vector3 = Vector3.ZERO
@export var speed:float = 20

func _process(delta):
	rotate(Rotation,speed*delta)
