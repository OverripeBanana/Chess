extends Piece

class_name King

@onready var diagonal_movement = $Movement/DiagonalMovement
@onready var horizontal_movement = $Movement/HorizontalMovement


func _ready():
	initPiece()

func _process(_delta):
	if mostRecentSquare == null:
		setMostRecentSquare()
	isInCheck()
	legal_squares = horizontal_movement.objects_collide + diagonal_movement.objects_collide
	move()
	if Input.is_action_just_released("left_click"):
		resetMovementComponents()
	

func isInCheck():
	if self.color == ChessColor.chess_color.BLACK:
		if mostRecentSquare.protectedByWhite:
			Check.blackInCheck = true
		else:
			Check.blackInCheck = false
	elif self.color == ChessColor.chess_color.WHITE:
		if mostRecentSquare.protectedByBlack:
			Check.whiteInCheck = true
		else:
			Check.whiteInCheck = false


