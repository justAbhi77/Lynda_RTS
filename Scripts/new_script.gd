extends Node3D

@export var DisplayItemPath:NodePath
var DisplayItem

func _ready():
	print("start")
	DisplayItem = get_node(DisplayItemPath)
	print("start",DisplayItemPath,DisplayItem)
	remove_child(DisplayItem)	
	print("end",DisplayItemPath,DisplayItem)
