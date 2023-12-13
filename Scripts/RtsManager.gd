class_name RTSManager extends Node3D

static var Current:RTSManager = null

@export var Players:Array[PlayerSetupDefinitions] = []

@onready var unitsParent:Node3D = $"../../Units"

func _ready():
	Current = self
		
	var units
	var GotNode
	
	for p in Players:
		GotNode = get_node(p.Location_path)
		for u in p.StartingUnits:
			units = u.instantiate()
			units.position = GotNode.position
			units.rotation = GotNode.rotation
			unitsParent.add_child(units)
