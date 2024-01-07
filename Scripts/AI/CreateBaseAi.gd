extends AiBehaviour

class_name CreateBaseAi

var Support:AiSupport = null

@export var Cost:float = 200

@export var UnitsperBase:int = 5

@export var RangefromDrone:float = 5

@export var TriesPerDrone:int = 3

var BuildingPrefab:PackedScene

func _ready():	
	BuildingPrefab = get_node("/root/World").BuildingPrefab

func GetWeight()-> float:
	if Support == null:
		Support = AiSupport.GetSupport(get_parent())
	
	if Support._Player.Credits < Cost or len(Support.Drones) == 0:
		return 0

	if len(Support.Commandbases) * UnitsperBase <= len(Support.Drones):
		return 1
	
	return 0;

func Execute():
	print("Creating Base")

	var go = BuildingPrefab.instantiate()
	var PlayerInfo = Player.new()
	PlayerInfo.name = "Player"
	go.name = "Command Base"
	PlayerInfo.Info = Support._Player
	go.add_child(PlayerInfo,true)
	get_node("/root/World").add_child(go,true)

	for drone in Support.Drones:
		for i in range(0,TriesPerDrone):
			var pos = drone.global_position
			pos+= Vector3(randf(),randf(),randf()) * RangefromDrone
			pos.y = 0.3
			go.global_position = pos
			if (RTSManager.Current.isGameObjectSafeToPlace(go)):
				Support._Player.Credits -= Cost

				var obs = go.get_node("MeshInstance3D")
			
				var navmesh:NavigationRegion3D = get_node("/root/World/NavigationRegion3D")
				var wallsparent = get_node("/root/World/NavigationRegion3D/Terrain/Walls")
				
				go.remove_child(obs)
				wallsparent.add_child(obs,true)
				
				obs.global_position = pos
				obs.scale = Vector3.ONE
				
				navmesh.bake_navigation_mesh()

				return
	
	go.queue_free()
