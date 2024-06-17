extends Node2D

class_name Movement

var objects_collide = []
var directions = []
var DISTANCE_FROM_PIECE = 50
@export var maxRayDistance : int 

func initRays():
	for ray in directions:
		ray.collide_with_areas = true
		ray.set_collision_mask_value(1, true)
		ray.set_collision_mask_value(2, true)
		
func getAllObjects():
	for ray in directions:	
		if ray.is_colliding():
			#ray.force_raycast_update()
			var obj = ray.get_collider()
			if obj != null:
				if obj.collision_layer != 2:
					obj.protected = self.get_parent().get_parent().color
					print(obj.protected)
					ray.add_exception(obj)
			objects_collide.append(obj)
			
