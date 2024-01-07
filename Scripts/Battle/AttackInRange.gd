extends Node3D

class_name AttackInRange

@export var ImpactVisual:PackedScene
@export var FindTargetDelay:float = 1

@export var AttackRange:float = 3

@export var AttackFrequency:float = 0.25

@export var AttackDamage:float = 1;

var target:ShowUnitInfo
var player:PlayerSetupDefinitions

var findTargetCounter:float
var attackCounter:float

func _ready():
	player = get_parent().get_node("Player").Info

func FindTarget():
	if target != null:
		return
	for p in RTSManager.Current.Players:
		if p == player:
			continue
		for unit in p.ActiveUnits:
			if unit.global_position.distance_to(global_position) < AttackRange:
				target = unit.get_parent().get_node("ShowUnitInfo")
				return

func Attack():
	if target == null:
		return
	
	if target.global_position.distance_to(global_position) > AttackRange:
		target = null
		return
	
	if ImpactVisual != null:
		var go = ImpactVisual.instantiate()
		get_node("/root/World").add_child(go)
		go.global_position = global_position

	target.CurrentHealth -= AttackDamage

func _process(delta):
	
	findTargetCounter += delta
	if findTargetCounter > FindTargetDelay:
		FindTarget()
		findTargetCounter = 0

	attackCounter += delta
	if attackCounter > AttackFrequency:
		Attack()
		attackCounter = 0
