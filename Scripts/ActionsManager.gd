extends Node

class_name ActionsManager

static var Current

var Buttons:Array[Button]

var actionCalls:Array = []

func _init():
	Current = self

func ClearButtons():
	for b in Buttons:
		b.disabled = true
	actionCalls.clear()

func AddButton(pic:Texture,OnClick:Callable):
	var index:int = len(actionCalls)
	Buttons[index].disabled = false
	Buttons[index].icon = pic
	actionCalls.append(OnClick)

func OnButtonClicked(index:int):
	actionCalls[index].call()

func _ready():
	var ButtonsParent = get_node("/root/World/UI/Hud/Actions/GridContainer")
	
	for i in range(ButtonsParent.get_child_count()):
		var child = ButtonsParent.get_child(i)
		Buttons.append(child)
	
	for i in range(len(Buttons)):
		var index = i
		Buttons[index].pressed.connect(
			func():
			OnButtonClicked(index)
			)
	ClearButtons()
