extends Interaction

class_name ShowUnitInfo

@export var Name:String
@export var maxHealth:float
@export var CurrentHealth:float
@export var ProfilePic:Texture

var show:bool = false

func Select():

	show = true

func _process(_delta):
	if !show:
		return
	InfoManager.Current.SetPic(ProfilePic)
	InfoManager.Current.SetLines(
		Name,
		str(CurrentHealth,"/",maxHealth),
		str("Owner: ",get_parent().get_node("Player").Info.Name)
	)

func Deselect():
	show = false
	InfoManager.Current.ClearPic()
	InfoManager.Current.ClearLines()
