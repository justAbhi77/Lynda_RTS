extends Node

@export var MeshInst:Array[MeshInstance3D]

func _ready():
	var playerColor = get_parent().get_node("Player").Info.AccentColor
	var mat
	for mesh in MeshInst:
		if !mat:
			mat = mesh.get_active_material(0).duplicate()
		mesh.material_override = mat
		mat.albedo_color = playerColor
