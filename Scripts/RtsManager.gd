class_name RTSManager extends Node3D

var Current:RTSManager = null

@export var Players:Array[PlayerSetupDefinitions] = []

func _ready():
	Current = self
