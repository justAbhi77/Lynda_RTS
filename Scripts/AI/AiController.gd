extends Node3D

class_name AiController

@export var PlayerName:String
@export var Confusion:float = 0.3
@export var Frequency:float = 1

var player:PlayerSetupDefinitions
var waited:float = 0
var Ais:Array[AiBehaviour] = []

var _Player:PlayerSetupDefinitions:
	get:
		return player

func _ready():
	for i in get_children():
		if i is AiBehaviour:
			Ais.append(i)
	for p in RTSManager.Current.Players:
		if p.Name == PlayerName:
			player = p
	var aisupport = AiSupport.new()
	aisupport.name = "AiSupport"
	add_child(aisupport,true)
	aisupport._Player = player

func _process(_delta):

	waited += _delta

	if waited < Frequency:
		return

	var bestAiValue = -999
	var bestAi:AiBehaviour = null
	
	AiSupport.GetSupport(self).Refresh()

	for ai in Ais:
		ai.Timepassed += waited
		
		var AiValue = ai.GetWeight() * ai.WeightMultiplier + randf_range(0 , Confusion)

		if AiValue > bestAiValue:
			bestAiValue = AiValue
			bestAi = ai
	
	bestAi.Execute()

	waited = 0
