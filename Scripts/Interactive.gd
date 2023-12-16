extends Node3D

class_name Interactive

var _Selected:bool = false
var Selected:bool :
	get:
		return _Selected

@export var Swap:bool = false 

@export var InterationsArray:Array[Interaction] = []

func Select():
	_Selected = true
	for selection in InterationsArray:
		selection.Select()
	
func Deselect():
	_Selected = false
	for selection in InterationsArray:
		selection.Deselect()

func _process(_delta):
	if Swap:
		Swap = false
		if _Selected:
			Deselect()
		else:
			Select()
