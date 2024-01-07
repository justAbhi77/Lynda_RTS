extends Node3D

class_name AiSupport

var Drones:Array[Node3D]
var Commandbases:Array[Node3D]

var _Player:PlayerSetupDefinitions

static func GetSupport(go:Node3D)->AiSupport:
	return go.get_node("AiSupport")

func Refresh():
	Drones.clear()
	Commandbases.clear()
	for u in _Player.ActiveUnits:
		var u_name = u.get_parent().name
		if u_name.contains("Drone_Unit"):
			Drones.append(u)
		if u_name.contains("Command Base"):
			Commandbases.append(u)
