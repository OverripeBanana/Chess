extends Movement

class_name DiagonalMovement

var upRight = RayCast2D.new()
var upLeft = RayCast2D.new()
var downLeft = RayCast2D.new()
var downRight = RayCast2D.new()

func _ready():
	directions.append(upRight)
	directions.append(upLeft)
	directions.append(downLeft)
	directions.append(downRight)
	initRays()
	castRays(maxRayDistance)
	
func _physics_process(_delta):
	for ray in directions:
		getAllObjects(ray)
	
func castRays(maxDistance):
	var DIAGONAL_DISTANCE_FROM_PIECE = DISTANCE_FROM_PIECE * 0.8
	var diagonal = 45
	add_child(upRight)
	add_child(upLeft)
	add_child(downLeft)
	add_child(downRight)
	upRight.target_position = Vector2.UP.rotated(deg_to_rad(diagonal)) * maxDistance
	upLeft.target_position = Vector2.UP.rotated(-deg_to_rad(diagonal)) * maxDistance	
	downLeft.target_position = Vector2.DOWN.rotated(-deg_to_rad(diagonal)) * maxDistance	
	downRight.target_position = Vector2.DOWN.rotated(deg_to_rad(diagonal)) * maxDistance	
	upRight.position = Vector2(DIAGONAL_DISTANCE_FROM_PIECE, -DIAGONAL_DISTANCE_FROM_PIECE)
	upLeft.position = Vector2(-DIAGONAL_DISTANCE_FROM_PIECE, -DIAGONAL_DISTANCE_FROM_PIECE)
	downLeft.position = Vector2(DIAGONAL_DISTANCE_FROM_PIECE, DIAGONAL_DISTANCE_FROM_PIECE)
	downRight.position = Vector2(-DIAGONAL_DISTANCE_FROM_PIECE, DIAGONAL_DISTANCE_FROM_PIECE)
