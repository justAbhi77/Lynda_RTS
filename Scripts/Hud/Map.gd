extends Control

class_name Map

@export var ViewPort:Control
@export var Corner1:Node3D
@export var Corner2:Node3D
@export var BlipPrefab:PackedScene

static var Current:Map

var terrainSize:Vector2
var mapRect:Control
var Camera:Camera3D

func _init():
	Current = self

func _ready():
	Camera = get_viewport().get_camera_3d()
	Corner1 = get_node("/root/World/NavigationRegion3D/Corner1")
	Corner2 = get_node("/root/World/NavigationRegion3D/Corner2")
	terrainSize = Vector2(abs(Corner2.position.x-Corner1.position.x),abs(Corner2.position.z-Corner1.position.z))

func WorldPositionToMap(point:Vector3)->Vector2:
	#var pos = point-Corner1.position
	var mapPos = Vector2(
		point.x / terrainSize.x * size.x,
		point.z / terrainSize.y * size.y)
	return mapPos

func _physics_process(_delta):
	ViewPort.position = WorldPositionToMap(Camera.position)
