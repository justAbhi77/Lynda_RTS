extends Interaction

class_name ActionSelect

@export var actionBehaviours:Array[ActionBehaviour] = []

func _enter_tree():
	var parent = get_parent()
	for i in parent.get_children():
		if i is ActionBehaviour:
			actionBehaviours.append(i)

func Deselect():
	ActionsManager.Current.ClearButtons()

func Select():
	ActionsManager.Current.ClearButtons()
	for ab in actionBehaviours:
		ActionsManager.Current.AddButton(
			ab.ButtonPic,
			ab.GetClickAction())
