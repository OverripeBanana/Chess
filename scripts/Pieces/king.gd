extends Piece

class_name King

@onready var diagonal_movement = $Movement/DiagonalMovement
@onready var horizontal_movement = $Movement/HorizontalMovement
var attackers = []

var white_rook
var white_rook_2
var black_rook
var black_rook_2

var leftCastle : bool = false
var rightCastle : bool = false
func _ready():
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
	print(rightCastle)
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
				if returnCloserObject(searchForClosestSquare(), Vector2(650, 50)) == Vector2(650, 50):
					#right
					if GameManager.blackRightCastle and !black_rook_2.hasMoved:
						rightCastle = true
					else:
						rightCastle = false
				else:
					rightCastle = false
					
				if returnCloserObject(searchForClosestSquare(), Vector2(250, 50)) == Vector2(250, 50):
					#left
					if GameManager.blackLeftCastle and !black_rook.hasMoved:
						leftCastle = true
					else:
						leftCastle = false
				else:
					leftCastle = false
					
			else:
				rightCastle = false
				leftCastle = false
				
		if self.color == 1:
			if !Check.whiteInCheck:
				if returnCloserObject(searchForClosestSquare(), Vector2(650, 750)) == Vector2(650, 750):
					#right
					if GameManager.whiteRightCastle and !white_rook.hasMoved:
						rightCastle = true
					else:
						rightCastle = false
				else:
					rightCastle = false
				if returnCloserObject(searchForClosestSquare(), Vector2(250, 750)) == Vector2(250, 750):
					#left
					if GameManager.whiteLeftCastle and !white_rook_2.hasMoved:
						leftCastle = true
					else:
						leftCastle = false
				else:
					leftCastle = false
			else:
				rightCastle = false
				leftCastle = false
	else:
		rightCastle = false
		leftCastle = false
