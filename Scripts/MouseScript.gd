extends Node3D

class_name MouseManager

static var Current:MouseManager

@export var RAY_LENGTH:float = 100

@onready var cam:Camera3D = get_viewport().get_camera_3d()

var Selections:Array[Interactive] = []

@export var overUI:bool = false

var enabled:bool = true

func _init():
	Current = self

#func _process(_delta):
	#if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#return
	#
	#if overUI:
		#return
	#
	#if len(Selections) > 0:
		#if !Input.is_key_pressed(KEY_SHIFT):
			#for sel in Selections:
				#if sel:
					#sel.Deselect()
			#Selections.clear()
	#
	#var space_state = get_world_3d().direct_space_state
	#var mousepos = get_viewport().get_mouse_position()
	#
	#var origin = cam.project_ray_origin(mousepos)
	#var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	#var query = PhysicsRayQueryParameters3D.create(origin, end)
	#query.collide_with_areas = true
#
	#var result = space_state.intersect_ray(query)
	#
	#if result.is_empty():
		#return
	#
	#if !result.collider and !result.collider.get_owner():
		#return
	#
	#var interactive = result.collider.get_owner() is UnitManager
	#if !interactive:
		#return
	#
	#Selections.append(result.collider.get_owner().interactions)
	#result.collider.get_owner().interactions.Select()

func _unhandled_input(event):
	
	if !enabled: return
	
	# Check if the left mouse button is pressed
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Check if the mouse is over UI
		if overUI:
			return

		# Clear selections if not holding SHIFT
		if len(Selections) > 0 and !Input.is_key_pressed(KEY_SHIFT):
			for sel in Selections:
				if sel:
					sel.Deselect()
			Selections.clear()

		# Perform raycast
		var space_state = get_world_3d().direct_space_state
		var mouse_pos = get_viewport().get_mouse_position()
		var origin = cam.project_ray_origin(mouse_pos)
		var end = origin + cam.project_ray_normal(mouse_pos) * RAY_LENGTH
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true

		var result = space_state.intersect_ray(query)

		if !result.is_empty() and result.collider and result.collider.get_owner() and result.collider.get_owner() is UnitManager:
			var interactive = result.collider.get_owner()
			Selections.append(interactive.interactions)
			interactive.interactions.Select()
