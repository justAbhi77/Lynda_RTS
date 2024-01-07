extends AiBehaviour

class_name CreateDronesAi

@export var DronesPerBase:int = 5
@export var Cost:float = 25

var Support:AiSupport

func GetWeight()-> float:
	if Support == null:
		Support = AiSupport.GetSupport(get_parent())	
	
	if Support._Player.Credits < Cost :
		return 0
	
	var drones = len(Support.Drones)
	var bases = len(Support.Commandbases)

	if bases == 0:
		return 0
	if drones >= bases * DronesPerBase:
		return 0
	
	return 1

func Execute():
	print(Support._Player.Name," is creating a Drone")

	var bases = Support.Commandbases
	var index = randi_range(0,len(bases)-1)
	var commandbase = bases[index]

	commandbase.get_node("../CreateUnitAction").GetClickAction().call()
