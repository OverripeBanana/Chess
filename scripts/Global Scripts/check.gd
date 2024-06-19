extends Node

var blackInCheck : bool = false
var whiteInCheck : bool = false
var blackCancelCheckSquares = []
var whiteCancelCheckSquares = []
var blackPieces
var whitePieces

func _ready():
	TurnManager.blackTurnFinished.connect(_on_black_turn_finished)
	TurnManager.whiteTurnFinished.connect(_on_white_turn_finished)

func _on_black_turn_finished():
	if whiteInCheck:
		await get_tree().create_timer(0.2).timeout
		for piece in whitePieces:
			if piece.get_name() != "White King":
				for square in piece.legal_squares:
					if square in whiteCancelCheckSquares:
						print("not checkmate")
						break
					elif square == piece.legal_squares.back() and square not in whiteCancelCheckSquares and piece == whitePieces.back():
						print("can't block or capture")
				
func _on_white_turn_finished():
	if blackInCheck:
		await get_tree().create_timer(0.2).timeout
		for piece in blackPieces:
			if piece.get_name() != "Black King":
				for square in piece.legal_squares:
					if square in blackCancelCheckSquares:
						print("not checkmate")
						break
					elif square == piece.legal_squares.back() and square not in blackCancelCheckSquares:
						print("can't block or capture")	



					
