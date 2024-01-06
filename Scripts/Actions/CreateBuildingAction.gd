extends ActionBehaviour

class_name CreateBuildingAction

@export var Cost:float = 0
@export var BuildingPrefab:PackedScene
@export var MaxBuildDistance:float = 30

@export var GhostBuildingPrefab:PackedScene
var active:Node3D = null

func GetClickAction():
	return func():
		var player = get_parent().get_node("Player").Info

		if player.Credits < Cost:
			print("less")
			return

		var go = GhostBuildingPrefab.instantiate()
		var finder = FindBuildingSite.new()
		finder.BuildingPrefab = BuildingPrefab
		finder.MaxBuildDistance = MaxBuildDistance
		finder.Info = player
		finder.Source = self
		go.add_child(finder)
		active = go
		add_child(go)

func _process(_delta):
	if active == null: return
	
	if Input.is_key_pressed(KEY_ESCAPE):
		active.queue_free()

func _exit_tree():
	if active == null: return
	active.queue_free()
