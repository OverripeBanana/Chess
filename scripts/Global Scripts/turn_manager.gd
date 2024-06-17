extends Node

var currentTurn : ChessColor.chess_color

func _ready():
	currentTurn = ChessColor.chess_color.WHITE

func switchTurn():
	if currentTurn == ChessColor.chess_color.WHITE:
		currentTurn = ChessColor.chess_color.BLACK
	elif currentTurn == ChessColor.chess_color.BLACK:
		currentTurn = ChessColor.chess_color.WHITE
