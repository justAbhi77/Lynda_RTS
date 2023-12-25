extends Interaction

class_name ShowUnitInfo

@export var Name:String
@export var maxHealth:float
@export var CurrentHealth:float
@export var ProfilePic:Texture

func Select():
	InfoManager.Current.SetPic(ProfilePic)
	InfoManager.Current.SetLines(
		Name,
		str(CurrentHealth,"/",maxHealth),
		str("Owner: ",get_parent().get_node("Player").Info.Name)
	)

func Deselect():
	InfoManager.Current.ClearPic()
	InfoManager.Current.ClearLines()
