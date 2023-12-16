extends Node3D

@export var RAY_LENGTH:float = 100

@onready var cam:Camera3D = get_viewport().get_camera_3d()

var Selections:Array[Interactive] = []

@export var overUI:bool = false

func _process(_delta):
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	
	if overUI:
		return
	
	if len(Selections) > 0:
		if !Input.is_key_pressed(KEY_SHIFT):
			for sel in Selections:
				if sel:
					sel.Deselect()
			Selections.clear()
	
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	
	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	if result.is_empty():
		return
	
	if !result.collider and !result.collider.get_owner():
		return
	
	var interactive = result.collider.get_owner() is UnitManager
	if !interactive:
		return
	
	Selections.append(result.collider.get_owner().interactions)
	result.collider.get_owner().interactions.Select()
