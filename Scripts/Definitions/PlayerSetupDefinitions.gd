extends Resource

class_name PlayerSetupDefinitions 

@export var Name:String = ""

@export var Location_path:NodePath

@export var AccentColor:Color

@export var StartingUnits:Array[PackedScene] = []

var activeUnits:Array[Node3D] 

var ActiveUnits:Array[Node3D]:
	get:
		return activeUnits

@export var IsAi:bool

@export var Credits:float
