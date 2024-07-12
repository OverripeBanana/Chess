extends Node2D

class_name Pieces

@onready var black = $Black
@onready var white = $White

var blackPieces = []
var whitePieces = []

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

func spawnPiece(piece, position):
	var myPiece = piece.instantiate()
	add_child(myPiece)
	myPiece.global_position = position
