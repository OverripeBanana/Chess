extends Node2D

class_name Pieces

@onready var black = $Black
@onready var white = $White

var blackPieces = []
var whitePieces = []
var blackMoves = []
var whiteMoves = []

#white
var white_king = preload("res://scenes/pieces/white/white_king.tscn")
var white_queen = preload("res://scenes/pieces/white/white_queen.tscn")
var white_bishop = preload("res://scenes/pieces/white/white_bishop.tscn")
var white_rook = preload("res://scenes/pieces/white/white_rook.tscn")
#black
var black_king = preload("res://scenes/pieces/black/black_king.tscn")
var black_queen = preload("res://scenes/pieces/black/black_queen.tscn")
var black_bishop = preload("res://scenes/pieces/black/black_bishop.tscn")
var black_rook = preload("res://scenes/pieces/black/black_rook.tscn")
	
func _process(_delta):
	blackPieces = black.get_children()
	whitePieces = white.get_children()
	Check.blackPieces = blackPieces
	Check.whitePieces=  whitePieces
	for piece in blackPieces:
		if "King" not in piece.get_name():
			for square in piece.legal_squares:
				if square not in blackMoves:
					blackMoves.append(square)
	for piece in whitePieces:
		if "King" not in piece.get_name():
			for square in piece.legal_squares:
				if square not in whiteMoves:
					whiteMoves.append(square)
	if Input.is_action_just_released("left_click"):
		blackMoves.clear()
		whiteMoves.clear()
	checkForStalemate()
	
func spawnPiece(piece, pos):
	var myPiece = piece.instantiate()
	if myPiece.color == 0:
		black.add_black_child(myPiece)
	if myPiece.color == 1:
		white.add_white_child(myPiece)
			
	myPiece.global_position = pos

func checkForStalemate():
	#print(GameManager.canBlackKingMove)
	#print(len(blackMoves))
	if len(blackMoves) == 0 or len(whiteMoves) == 0:
		if !GameManager.canWhiteKingMove or !GameManager.canBlackKingMove:
			GameManager.winState = GameManager.WinStates.STALEMATE
			get_tree().quit()
