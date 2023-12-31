extends ActionBehaviour

class_name CreateBuildingAction

@export var GhostBuildingPrefab:PackedScene
var active:Node3D = null

func GetClickAction():
	return func():
		var go = GhostBuildingPrefab.instantiate()
		go.add_child(FindBuildingSite.new())
		active = go
		add_child(go)

func _process(_delta):
	if active == null: return
	
	if Input.is_key_pressed(KEY_ESCAPE):
		active.queue_free()

func _exit_tree():
	if active == null: return
	active.queue_free()	
