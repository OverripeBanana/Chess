extends Piece

class_name Bishop

@onready var diagonal_movement = $Movement/DiagonalMovement

func _ready():
	initPiece()

func _process(_delta):
	if mostRecentSquare == null:
		setMostRecentSquare()
		
	legal_squares = diagonal_movement.objects_collide
	removeOccupiedSquares()
	if Input.is_action_just_released("left_click"):
		await get_tree().create_timer(0.2).timeout
		resetMovementComponents()
	move()
