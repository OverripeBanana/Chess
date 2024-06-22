extends Piece

class_name Queen

@onready var diagonal_movement = $Movement/DiagonalMovement
@onready var horizontal_movement = $Movement/HorizontalMovement

func _ready():
	initPiece()
	
func _process(_delta):
	if mostRecentSquare == null:
		setMostRecentSquare()
		
	legal_squares = horizontal_movement.objects_collide + diagonal_movement.objects_collide
	removeOccupiedSquares()
	if Input.is_action_just_released("left_click"):
		resetMovementComponents()
	move()
	
	

