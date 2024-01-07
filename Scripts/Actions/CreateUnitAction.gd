extends ActionBehaviour

class_name CreateUnitAction

@export var Cost:float = 0
var UnitPrefab:PackedScene

var player:PlayerSetupDefinitions

func _ready():
	UnitPrefab = get_node("/root/World").UnitPrefab

func GetClickAction():
	return func():
		if player == null:
			player = get_parent().get_node("Player").Info

		if player.Credits < Cost:
			print("Can not create unit")
			return

		var go = UnitPrefab.instantiate()
		var PlayerInfo = Player.new()
		PlayerInfo.Info = player
		go.add_child(PlayerInfo,true)
		PlayerInfo.name = "Player"
		
		if !go.has_node("RightClickInteraction"):
			var rightclickinter = RightClickInteraction.new()
			rightclickinter.name = "RightClickInteraction"
			go.add_child(rightclickinter,true)
			go.interactions.InterationsArray.append(rightclickinter)

		var actionSelect = ActionSelect.new()
		actionSelect.name = "ActionSelect"
		go.add_child(actionSelect,true)
		go.interactions.InterationsArray.append(actionSelect)

		player.Credits -= Cost
		RTSManager.Current.unitsParent.add_child(go,true)
		go.rotation = Vector3.ZERO

		var navmesh:NavigationRegion3D = get_node("/root/World/NavigationRegion3D")
		var navmeshMapRid = navmesh.get_navigation_map()
		
		var hitpoint = NavigationServer3D.map_get_closest_point(navmeshMapRid,global_position)

		go.global_position = hitpoint
