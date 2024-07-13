extends Piece

class_name Knight

var protected_squares = []

func _ready():
	initPiece()

func _process(_delta):
	if mostRecentSquare == null:
		setMostRecentSquare()
		
	legal_squares = movement.get_overlapping_areas()
	removeOccupiedSquares()
	for square in legal_squares:
		protect(square)
		
	if Input.is_action_just_released("left_click"):
		await get_tree().create_timer(RESET_WAIT_TIME).timeout
		legal_squares.clear()
		protected_squares.clear()
	

	move()

func protect(obj):
	if self.color == ChessColor.chess_color.BLACK:
		obj.protectedByBlack = true
	elif self.color == ChessColor.chess_color.WHITE:
		obj.protectedByWhite = true
		
	if self not in obj.protectors:
		obj.protectors.append(self)
