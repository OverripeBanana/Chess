extends Piece

class_name King

@onready var board = $"../../../Board"
@onready var diagonal_movement = $Movement/DiagonalMovement
@onready var horizontal_movement = $Movement/HorizontalMovement
var attackers = []
var castle_squares = []
var white_rook
var white_rook_2
var black_rook
var black_rook_2

func _ready():
	self.finishedMovement.connect(_on_finished_movement)
	initPiece()
	if self.color == 0:
		black_rook = $"../Black Rook"
		black_rook_2 = $"../Black Rook2"
	if self.color == 1:
		white_rook = $"../White Rook"
		white_rook_2 = $"../White Rook2"
	
func _process(_delta):
	if mostRecentSquare == null:
		setMostRecentSquare()
	canCastle()
	check()
	getAttackers()
	
	isInStalemate()
	legal_squares = horizontal_movement.objects_collide + diagonal_movement.objects_collide + castle_squares
	removeOccupiedSquares()
	move()
	
	if Input.is_action_just_released("left_click"):		
		await get_tree().create_timer(RESET_WAIT_TIME).timeout
		resetMovementComponents()
		attackers.clear()

func getAttackers():
	for piece in mostRecentSquare.protectors:
		if is_instance_valid(piece):
			if piece.color != self.color:
				if piece not in attackers:
					attackers.append(piece)	
		else:
			attackers.erase(piece)
			
			
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

func canCastle():
	if !hasMoved:
		
		if self.color == 0:
			if !Check.blackInCheck:
					if GameManager.blackRightCastle and !black_rook_2.hasMoved:
						#right
						if board.white_square_2 not in castle_squares:
							castle_squares.append(board.white_square_2)
					else:
						if mostRecentSquare != board.white_square_2:
							castle_squares.erase(board.white_square_2)
						
					if GameManager.blackLeftCastle and !black_rook.hasMoved:
						#left		
						if board.white_square_4 not in castle_squares:
							castle_squares.append(board.white_square_4)
					else:
						if mostRecentSquare != board.white_square_4:
							castle_squares.erase(board.white_square_4)
						
		if self.color == 1:
			if !Check.whiteInCheck:
					if GameManager.whiteRightCastle and !white_rook.hasMoved:
						#right
						if board.black_square_24 not in castle_squares:
							castle_squares.append(board.black_square_24)
					else:
						if mostRecentSquare != board.black_square_24:
							castle_squares.erase(board.black_square_24)
						
					if GameManager.whiteLeftCastle and !white_rook_2.hasMoved:
						#left
						if board.black_square_22 not in castle_squares:
							castle_squares.append(board.black_square_22)
					else:
						if mostRecentSquare != board.black_square_22:
							castle_squares.erase(board.black_square_22)
						
func performCastle():
	if self.color == 0:
		if self.position == Vector2(250, 50):
			black_rook_2.position = Vector2(350, 50)
			black_rook_2.resetMovementComponents()
		if self.position == Vector2(650, 50):
			black_rook.position = Vector2(550, 50)
			black_rook.resetMovementComponents()
			
	if self.color == 1:
		if self.position == Vector2(650, 750):
			white_rook.position = Vector2(550, 750)
			white_rook.resetMovementComponents()
		if self.position == Vector2(250, 750):
			white_rook_2.position =  Vector2(350, 750)
			white_rook_2.resetMovementComponents()			


func _on_finished_movement():
	if mostRecentSquare in castle_squares:
		performCastle()
		castle_squares.erase(mostRecentSquare)
