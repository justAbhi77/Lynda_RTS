extends Node3D

class_name Player

var Info:PlayerSetupDefinitions

static var Default:PlayerSetupDefinitions

func _ready():
	Info.ActiveUnits.append(self)

func _exit_tree():
	Info.ActiveUnits.erase(self)

