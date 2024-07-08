extends Movement

class_name RayCastMovement

var directions = []
var DISTANCE_FROM_PIECE = 55
@export var maxRayDistance : int 

func initRays(ray):
	ray.collide_with_areas = true
	ray.set_collision_mask_value(1, true)
	ray.set_collision_mask_value(2, true)
		
func getAllObjects(ray):
	if ray.is_colliding():
		#ray.force_raycast_update()
		var obj = ray.get_collider()
		if obj != null:
			if obj.get_parent().get_name() == "White King" or obj.get_parent().get_name() == "Black King":
				ray.add_exception(obj)
				ray.collide_with_bodies = false
			if obj.collision_layer == 1:
				ray.add_exception(obj)
				if obj not in objects_collide and ray.collide_with_bodies:
					objects_collide.append(obj)
	else:
		ray.clear_exceptions()
		ray.collide_with_bodies = true
		
func protectAllObjects(ray):
	if ray.is_colliding():
		var obj = ray.get_collider()
		if obj != null:
			if obj.get_parent().get_name() == "White King" or obj.get_parent().get_name() == "Black King":
				ray.add_exception(obj)
				ray.collide_with_bodies = false
			if obj.collision_layer == 1:
				ray.add_exception(obj)
				if obj not in protected_squares and ray.collide_with_bodies:
					protected_squares.append(obj)
	else:
		ray.clear_exceptions()
		ray.collide_with_bodies = true		
		
		
func protect(obj):
	var myColor = self.get_parent().get_parent().color
	if myColor == ChessColor.chess_color.BLACK:
		obj.protectedByBlack = true
	elif myColor == ChessColor.chess_color.WHITE:
		obj.protectedByWhite = true
		
	if self.get_parent().get_parent() not in obj.protectors:
		obj.protectors.append(self.get_parent().get_parent())
	
func clearProtect(piece):
	for obj in protected_squares:
		if is_instance_valid(obj):
			if obj.collision_layer == 1:
				if piece.color == ChessColor.chess_color.BLACK:
					obj.protectedByBlack = false
				elif piece.color == ChessColor.chess_color.WHITE:
					obj.protectedByWhite = false
	protected_squares.clear()
	#if self.get_parent().get_name() == "White Queen":
		#print(protected_squares)
