extends Node

class_name CashBoxManager

@export var CasHField:Label

func _ready():
	CasHField = get_node("/root/World/UI/Hud/CashBox Image/Label")

func _process(_delta):
	CasHField.text = str("$",int(Player.Default.Credits))
