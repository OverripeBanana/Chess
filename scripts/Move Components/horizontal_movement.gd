extends RayCastMovement

class_name HorizontalMovement

var up = RayCast2D.new()
var down = RayCast2D.new()
var left = RayCast2D.new()
var right = RayCast2D.new()

func _ready():
	directions.append(up)
	directions.append(down)
	directions.append(left)
	directions.append(right)
	for ray in directions:
		initRays(ray)
	castRays(maxRayDistance)
	
func _physics_process(_delta):
	for ray in directions:
		getAllObjects(ray)
	for square in objects_collide:
		protect(square)
		
func castRays(maxDistance):
	add_child(up)
	add_child(down)
	add_child(left)
	add_child(right)
	up.target_position = Vector2.UP * maxDistance
	down.target_position = Vector2.DOWN * maxDistance
	left.target_position = Vector2.LEFT * maxDistance	
	right.target_position = Vector2.RIGHT * maxDistance
	up.position.y -= DISTANCE_FROM_PIECE
	down.position.y += DISTANCE_FROM_PIECE	
	left.position.x -= DISTANCE_FROM_PIECE
	right.position.x += DISTANCE_FROM_PIECE	

