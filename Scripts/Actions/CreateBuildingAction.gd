extends ActionBehaviour

class_name CreateBuildingAction

@export var Cost:float = 0
var BuildingPrefab:PackedScene
@export var MaxBuildDistance:float = 30

@export var GhostBuildingPrefab:PackedScene
var active:Node3D = null

func _ready():
	BuildingPrefab = get_node("/root/World").BuildingPrefab

func GetClickAction():
	return func():
		var player = get_parent().get_node("Player").Info

		if player.Credits < Cost:
			print("less")
			return

		var go = GhostBuildingPrefab.instantiate()
		go.name = "GhostBuilding"
		var finder = FindBuildingSite.new()
		finder.name = "BuildingFinder"
		finder.BuildingPrefab = BuildingPrefab
		finder.MaxBuildDistance = MaxBuildDistance
		finder.Info = player
		finder.Source = self
		go.add_child(finder,true)
		active = go
		add_child(go,true)

func _process(_delta):
	if active == null: return
	
	if Input.is_key_pressed(KEY_ESCAPE):
		active.queue_free()

func _exit_tree():
	if active == null: return
	active.queue_free()
