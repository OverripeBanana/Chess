extends Node

var currentTurn : ChessColor.chess_color

signal blackTurnFinished
signal whiteTurnFinished

func _ready():
	currentTurn = ChessColor.chess_color.WHITE

func switchTurn(pieceColor):
	if pieceColor == ChessColor.chess_color.BLACK:
		currentTurn = ChessColor.chess_color.WHITE
		emit_signal("blackTurnFinished")
	if pieceColor == ChessColor.chess_color.WHITE:
		currentTurn = ChessColor.chess_color.BLACK
		emit_signal("whiteTurnFinished")
		
func setTurn(color):
	currentTurn = color
