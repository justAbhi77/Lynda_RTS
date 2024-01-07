extends Node3D

class_name DestroyOnNoHealth

@export var explosionPrefab:PackedScene

var info:ShowUnitInfo

func _ready():
	info = get_parent().get_node("ShowUnitInfo")

func _process(_delta):
	if info.CurrentHealth <= 0:
		if explosionPrefab != null:
			var go = explosionPrefab.instantiate()
			get_node("/root/World").add_child(go)
			go.global_position = global_position
		get_parent().queue_free()