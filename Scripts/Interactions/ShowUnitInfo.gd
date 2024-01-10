extends Interaction

class_name ShowUnitInfo

@export var Name:String
@export var maxHealth:float
@export var CurrentHealth:float
@export var ProfilePic:Texture

var showUI:bool = false

func Select():

	showUI = true

func _process(_delta):
	if !showUI:
		return
	InfoManager.Current.SetPic(ProfilePic)
	InfoManager.Current.SetLines(
		Name,
		str(CurrentHealth,"/",maxHealth),
		str("Owner: ",get_parent().get_node("Player").Info.Name)
	)

func Deselect():
	showUI = false
	InfoManager.Current.ClearPic()
	InfoManager.Current.ClearLines()
