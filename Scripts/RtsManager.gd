class_name RTSManager extends Node3D

static var Current:RTSManager = null

@export var Players:Array[PlayerSetupDefinitions] = []

@export var RAY_LENGTH:float = 10000

@onready var unitsParent:Node3D = $"../../Units"

@onready var cam:Camera3D = get_viewport().get_camera_3d()

var mdt = MeshDataTool.new() 

var navmesh:NavigationRegion3D
var navmeshMapRid

func _init():
	Current = self

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
	

func findByClass(className : String, result : Array,node: Node) -> void:
	if node.is_class(className) :
		result.push_back(node)
	for child in node.get_children():
		findByClass(className, result, child)

func isGameObjectSafeToPlace(_go:Node3D)-> bool:
		
	var hitpoint = NavigationServer3D.map_get_closest_point(navmeshMapRid,_go.global_position)
	
	var onXAxis = abs(hitpoint.x-_go.global_position.x) < 0.25
	var onZAxis = abs(hitpoint.z-_go.global_position.z) < 0.25
	
	if !onXAxis or !onZAxis:
		return false
	return true

func _ready():

	navmesh = get_node("/root/World/NavigationRegion3D")
	navmeshMapRid = navmesh.get_navigation_map()

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
			player.name = "Player"
			units.add_child(player,true)
			player.Info = p
			if !p.IsAi:
				if player.Default == null:
					player.Default = p
				
				if !units.has_node("RightClickInteraction"):
					var rightInteraction = RightClickInteraction.new()
					rightInteraction.name = "RightClickInteraction"
					units.add_child(rightInteraction,true)
					units.interactions.InterationsArray.append(rightInteraction)
				
				var actionSelect = ActionSelect.new()
				actionSelect.name = "ActionSelect"
				units.add_child(actionSelect,true)
				units.interactions.InterationsArray.append(actionSelect)
