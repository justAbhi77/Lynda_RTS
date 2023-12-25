extends Node3D

class_name MapBlip

var blip

var Blip:
	get:
		return blip

func _ready():
	blip = Map.Current.BlipPrefab.instantiate()
	Map.Current.add_child(blip)
	var color = get_parent().get_node("Player").Info.AccentColor
	blip.modulate = color

func _physics_process(_delta):
	blip.position = Map.Current.WorldPositionToMapUI(global_position)

func _exit_tree():
	Map.Current.remove_child(blip)
	blip.queue_free()
