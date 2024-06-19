extends Piece

class_name King

@onready var diagonal_movement = $Movement/DiagonalMovement
@onready var horizontal_movement = $Movement/HorizontalMovement
var attackers = []

func _ready():
	initPiece()
	
func _process(_delta):
	if mostRecentSquare == null:
		setMostRecentSquare()
		
	check()
	
	getAttackers()
	
	legal_squares = horizontal_movement.objects_collide + diagonal_movement.objects_collide
	move()
	
	if Input.is_action_just_released("left_click"):
		resetMovementComponents()
		attackers.clear()

func getAttackers():
	for piece in mostRecentSquare.protectors:
		if piece.color != self.color:
			if piece not in attackers:
				attackers.append(piece)	

func check():
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


		
