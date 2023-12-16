extends Interaction

class_name Highlight

@export var DisplayItemPath:NodePath
var DisplayItem:Node

func Select():
	if DisplayItem.get_parent() == self:
		return
	add_child(DisplayItem)
	
func Deselect():
	if DisplayItem.get_parent() != self:
		return
	remove_child(DisplayItem)
	
func _ready():
	DisplayItem = get_node(DisplayItemPath)
	get_parent().remove_child.call_deferred(DisplayItem)

