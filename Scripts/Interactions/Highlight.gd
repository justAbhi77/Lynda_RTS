extends Interaction

class_name Highlight

@export var DisplayItemPath:NodePath
var DisplayItem:Node

func Select():
	add_child(DisplayItem)
	pass
	
func Deselect():
	remove_child(DisplayItem)
	
func _ready():
	DisplayItem = get_node(DisplayItemPath)
	get_parent().remove_child.call_deferred(DisplayItem)

