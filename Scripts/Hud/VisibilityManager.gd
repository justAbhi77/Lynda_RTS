extends Node

class_name VisibilityManager

@export var TimeBetweenChecks:float = 1
@export var VisibleRange:float = 7

var waited:float = 10000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	waited += delta
	if waited <= TimeBetweenChecks:
		return
	waited = 0
	var pblips:Array[Node3D]=[]
	var oblips:Array[Node3D]=[]
	
	for p in RTSManager.Current.Players:
		for u in p.ActiveUnits:
			var blip = u.get_parent().get_node("MapBlip")
			if p == Player.Default:
				pblips.append(blip)
			else:
				oblips.append(blip)
	
	for o in oblips:
		var active:bool = false
		for p in pblips:
			var distance = o.global_position.distance_to(p.global_position)
			if distance <= VisibleRange:
				active = true
				break
		o.blip.visible = active
		var parent =o.get_parent()

		if parent.has_node("Cube_001"):
			parent.get_node("Cube_001").visible = active
		else:
			parent.get_node("Cube").visible = active

		parent.get_node("AccentColors/AccentColor1").visible = active
		parent.get_node("AccentColors/AccentColor2").visible = active
