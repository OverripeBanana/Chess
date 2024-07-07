extends RayCastMovement

class_name PawnMovement

var TWO_SQUARES = 100
var ONE_SQUARE = 50

var forward = RayCast2D.new()

func _ready():
	directions.append(forward)
	initRays(forward)
	add_child(forward)
	forward.target_position = Vector2.UP * TWO_SQUARES
	forward.position.y -= DISTANCE_FROM_PIECE
	
func _physics_process(delta):
	getAllObjects(forward)
	for square in protected_squares:
		protect(square)
