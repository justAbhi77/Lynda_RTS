extends Node

class_name Earnings

@export var CreditsPerSecond:float = 1

var player:PlayerSetupDefinitions

func _ready():
	player = get_parent().get_node("Player").Info

func _process(delta):
	player.Credits += CreditsPerSecond * delta
