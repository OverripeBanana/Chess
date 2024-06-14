extends Node2D

class_name Movement

var objects_collide = []
var directions = []
@export var maxRayDistance : int
signal hit_square(square)

func initRays():
	for ray in directions:
		ray.collide_with_areas = true
		ray.collision_mask = 1
		
func getAllObjects():
	for ray in directions:
		ray.force_raycast_update()
		if ray.is_colliding():
			var obj = ray.get_collider()
			ray.add_exception(obj)
			emit_signal("hit_square", obj)
			objects_collide.append(obj)
			

			
