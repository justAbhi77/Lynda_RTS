extends Node3D

class_name FindBuildingSite

var parent

var red = Color.RED
var green = Color.GREEN
var mat

func _ready():
	parent=get_parent()
	mat = parent.get_node("Cube").material_override


func _process(_delta):
	var temptarget = RTSManager.Current.ScreenPointToMapPosition(get_viewport().get_mouse_position())
	if temptarget == null: return
	
	parent.global_position = temptarget
	
	if RTSManager.Current.isGameObjectSafeToPlace(parent):
		mat.albedo_color = green
	else :
		mat.albedo_color = red
