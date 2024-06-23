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
	
	isInStalemate()
	legal_squares = horizontal_movement.objects_collide + diagonal_movement.objects_collide
	removeOccupiedSquares()
	move()
	
	if Input.is_action_just_released("left_click"):
		await get_tree().create_timer(RESET_WAIT_TIME).timeout
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

func isInStalemate():
	for square in legal_squares:
		if self.color == ChessColor.chess_color.BLACK:
			if !square.protectedByWhite:
				Check.blackInStalemate = false
				return false
			if square.protectedByWhite and square == legal_squares.back():
				Check.blackInStalemate = true
				return true
		if self.color == ChessColor.chess_color.WHITE:
			if !square.protectedByBlack:
				Check.whiteInStalemate = false
				return false
			if square.protectedByBlack and square == legal_squares.back():	
				Check.whiteInStalemate = true
				return true		
		
