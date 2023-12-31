extends Interaction

class_name RightClickInteraction

@export var RelaxDistance:float = 0.01
@export var movement_speed: float = 4.0
@export var Agent:NavigationAgent3D 

var parent
var target:Vector3 = Vector3.ZERO
var movement_delta: float
var Selected:bool = false
var isActive:bool = false

func Select():
	Selected = true

func Deselect():
	Selected = false

func Sendtotarget(pos = null):
	if pos != null and pos is Vector3:
		target = pos
	Agent.set_target_position(target)
	isActive = true
	parent.navigationEnabled = isActive

func _ready():
	parent = get_parent()
	Agent = parent.get_node("NavigationAgent3D")
	
func _process(_delta):
	if Selected and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var temptarget = RTSManager.Current.ScreenPointToMapPosition(get_viewport().get_mouse_position())
		if temptarget != null:
			target = temptarget
			Sendtotarget()
	if isActive and target.distance_to(parent.position)<=RelaxDistance:
		isActive = false
		parent.navigationEnabled = isActive
		
