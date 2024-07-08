extends RayCastMovement

class_name PawnMovement

var TWO_SQUARES = 200
var ONE_SQUARE = 100

var forward = RayCast2D.new()
var attackRight = RayCast2D.new()
var attackLeft = RayCast2D.new()

var piece

func _ready():
	piece = self.get_parent().get_parent()
	
	var DIAGONAL_DISTANCE_FROM_PIECE = DISTANCE_FROM_PIECE * 0.8
	
	directions.append(forward)
	directions.append(attackRight)
	directions.append(attackLeft)
	for ray in directions:
		initRays(ray)
		add_child(ray)
	
	forward.target_position = Vector2.UP * TWO_SQUARES
	attackRight.target_position = Vector2.UP.rotated(deg_to_rad(45)) * ONE_SQUARE
	attackLeft.target_position = Vector2.UP.rotated(-deg_to_rad(45)) * ONE_SQUARE
	
	forward.position.y -= DISTANCE_FROM_PIECE
	attackRight.position = Vector2(DIAGONAL_DISTANCE_FROM_PIECE, -DIAGONAL_DISTANCE_FROM_PIECE)
	attackLeft.position = Vector2(-DIAGONAL_DISTANCE_FROM_PIECE, -DIAGONAL_DISTANCE_FROM_PIECE)
	
func _physics_process(delta):
	getAllObjects(forward)
	protectAllObjects(attackRight)
	protectAllObjects(attackLeft)
		
	for square in protected_squares:
		protect(square)
		if square.occupied != piece.color and square.occupied != 2:
			objects_collide.append(square)

func oneSquare():
	forward.target_position = Vector2.UP * ONE_SQUARE
