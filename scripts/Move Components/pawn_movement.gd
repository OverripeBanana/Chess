extends RayCastMovement

class_name PawnMovement

var TWO_SQUARES = 200
var ONE_SQUARE = 100

var forward = RayCast2D.new()
var attackRight = RayCast2D.new()
var attackLeft = RayCast2D.new()
var left = RayCast2D.new()
var right = RayCast2D.new()

var piece

func _ready():
	piece = self.get_parent().get_parent()
	
	var DIAGONAL_DISTANCE_FROM_PIECE = DISTANCE_FROM_PIECE * 0.8
	
	directions.append(forward)
	directions.append(attackRight)
	directions.append(attackLeft)
	directions.append(left)
	directions.append(right)
	
	for ray in directions:
		initRays(ray)
		add_child(ray)
	left.set_collision_mask_value(1, false)
	right.set_collision_mask_value(1, false)
	left.hit_from_inside = false
	right.hit_from_inside = false
	
	forward.target_position = Vector2.UP * TWO_SQUARES
	attackRight.target_position = Vector2.UP.rotated(deg_to_rad(45)) * ONE_SQUARE
	attackLeft.target_position = Vector2.UP.rotated(-deg_to_rad(45)) * ONE_SQUARE
	left.target_position = Vector2.LEFT * ONE_SQUARE
	right.target_position = Vector2.RIGHT * ONE_SQUARE
	
	forward.position.y -= DISTANCE_FROM_PIECE
	attackRight.position = Vector2(DIAGONAL_DISTANCE_FROM_PIECE, -DIAGONAL_DISTANCE_FROM_PIECE)
	attackLeft.position = Vector2(-DIAGONAL_DISTANCE_FROM_PIECE, -DIAGONAL_DISTANCE_FROM_PIECE)
	left.position.x -= DISTANCE_FROM_PIECE
	right.position.x += DISTANCE_FROM_PIECE
	
func _physics_process(_delta):
	getAllObjects(forward)
	protectAllObjects(attackRight)
	protectAllObjects(attackLeft)
	checkForEnPassant()
	for square in protected_squares:
		protect(square)
		if square.occupied != piece.color and square.occupied != 2:
			objects_collide.append(square)

func checkForEnPassant():
	if is_instance_valid(getPiece(left)):
		var leftPiece = getPiece(left).get_parent()
		if "White Pawn" in leftPiece.get_name() or "Black Pawn" in leftPiece.get_name():
			if leftPiece.enPassant:
				for square in protected_squares:
					objects_collide.append(square)
				
	if is_instance_valid(getPiece(right)):
		var rightPiece = getPiece(right).get_parent()
		if "White Pawn" in rightPiece.get_name() or "Black Pawn" in rightPiece.get_name():
			if rightPiece.enPassant:
				for square in protected_squares:
					objects_collide.append(square)
	
func oneSquare():
	forward.target_position = Vector2.UP * ONE_SQUARE
