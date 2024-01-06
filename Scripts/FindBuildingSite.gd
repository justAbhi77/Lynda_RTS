extends Node3D

class_name FindBuildingSite

var parent

var red = Color.RED
var green = Color.GREEN
var mat

@export var Cost:float = 200
@export var MaxBuildDistance:float = 30
@export var BuildingPrefab:PackedScene

@export var Info:PlayerSetupDefinitions

var Source:Node3D

func _ready():
	parent=get_parent()
	mat = parent.get_node("Cube").material_override
	
	MouseManager.Current.enabled = false


func _process(_delta):
	var temptarget = RTSManager.Current.ScreenPointToMapPosition(get_viewport().get_mouse_position())
	if temptarget == null: return
	
	parent.global_position = temptarget
	
	if temptarget.distance_to(Source.global_position) > MaxBuildDistance:
		mat.albedo_color = red
		return
	
	if RTSManager.Current.isGameObjectSafeToPlace(parent):
		mat.albedo_color = green
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			var go = BuildingPrefab.instantiate()
			var PlayerInfo = Player.new()
			go.add_child(PlayerInfo)
			Info.Credits -= Cost
			PlayerInfo.Info = Info
			PlayerInfo.name = "Player"
			get_node("/root/World").add_child(go)
			go.global_position = temptarget

			var obs = go.get_node("MeshInstance3D")

			var navmesh:NavigationRegion3D = get_node("/root/World/NavigationRegion3D")
			var wallsparent = get_node("/root/World/NavigationRegion3D/Terrain/Walls")
			
			go.remove_child(obs)
			wallsparent.add_child(obs)
			
			obs.global_position = temptarget
			obs.scale = Vector3.ONE

			navmesh.bake_navigation_mesh()
			
			get_parent().queue_free()
	else :
		mat.albedo_color = red

func _exit_tree():
	MouseManager.Current.enabled = true
