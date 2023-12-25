class_name RTSManager extends Node3D

static var Current:RTSManager = null

@export var Players:Array[PlayerSetupDefinitions] = []

@export var RAY_LENGTH:float = 10000

@onready var unitsParent:Node3D = $"../../Units"

@onready var cam:Camera3D = get_viewport().get_camera_3d()

func ScreenPointToMapPosition(point:Vector2):
	var space_state = get_world_3d().direct_space_state
	
	var origin = cam.project_ray_origin(point)
	var end = origin + cam.project_ray_normal(point) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, 
													end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	if result.is_empty():
		return null
	
	return result.position
	

func _ready():
	Current = self
		
	var units:UnitManager
	var GotNode
	
	for p in Players:
		GotNode = get_node(p.Location_path)
		for u in p.StartingUnits:
			units = u.instantiate()
			unitsParent.add_child(units,true)
			units.position = GotNode.position
			units.rotation = GotNode.rotation
			var player = Player.new()
			units.add_child(player,true)
			player.name = "Player"
			player.Info = p
			if !p.IsAi:
				if player.Default == null:
					player.Default = p
				var rightInteraction = RightClickInteraction.new()
				units.add_child(rightInteraction,true)
				units.interactions.InterationsArray.append(rightInteraction)
				var actionSelect = ActionSelect.new()
				units.add_child(actionSelect,true)
				units.interactions.InterationsArray.append(actionSelect)
