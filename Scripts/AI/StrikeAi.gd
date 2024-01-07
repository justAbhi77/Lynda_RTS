extends AiBehaviour

class_name StrikeAi

@export var DronesRequired:int = 10

@export var TimeDelay:float = 5

@export var SquadSize:float = 0.5

@export var IncreasePerwave:int = 10

func GetWeight()-> float:
	if Timepassed < TimeDelay:
		return 0
	Timepassed = 0
	
	var ai = AiSupport.GetSupport(get_parent())

	if len(ai.Drones) < DronesRequired:
		return 0
	return 1


func Execute():
	var ai = AiSupport.GetSupport(get_parent())
	print(ai._Player.Name," is Attacking")

	var wave:int = int(len(ai.Drones)* SquadSize) 
	DronesRequired += IncreasePerwave

	for p in RTSManager.Current.Players:
		if p.IsAi:
			continue
		for i in range(wave):
			var drone = ai.Drones[i]
			var nav = drone.get_parent().get_node("RightClickInteraction")
			nav.Sendtotarget(RTSManager.Current.get_node(p.Location_path).position)
		return
