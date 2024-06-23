extends Node

var blackInCheck : bool = false
var whiteInCheck : bool = false
var blackInStalemate : bool = false
var whiteInStalemate : bool = false
var blackCancelCheckSquares = []
var whiteCancelCheckSquares = []
var blackPieces
var whitePieces

func _ready():
	TurnManager.blackTurnFinished.connect(_on_black_turn_finished)
	TurnManager.whiteTurnFinished.connect(_on_white_turn_finished)

#func _process(delta):
	#print(GameManager.winState)
	#print(whiteInStalemate)
	#print(canWhiteBlockOrCapture())
	
func _on_black_turn_finished():
	await get_tree().create_timer(0.3).timeout
	if whiteInStalemate:
		if whiteInCheck:
			if !canWhiteBlockOrCapture():
				GameManager.winState = GameManager.WinStates.BLACK_WIN #the stupid diggas won
				get_tree().quit()

func _on_white_turn_finished():
	await get_tree().create_timer(0.3).timeout
	if blackInStalemate:
		if blackInCheck:
			if !canBlackBlockOrCapture():
				GameManager.winState = GameManager.WinStates.WHITE_WIN
				get_tree().quit()
	
func canBlackBlockOrCapture():
	for piece in blackPieces:
		if piece.get_name() != "Black King":
			for square in piece.legal_squares:
				if square in blackCancelCheckSquares:
					return true
				elif square == piece.legal_squares.back() and square not in blackCancelCheckSquares:
					return false

func canWhiteBlockOrCapture():
	if whitePieces != null:
		for piece in whitePieces:
			if piece.get_name() != "White King":
				for square in piece.legal_squares:
					if square in whiteCancelCheckSquares:
						return true
					elif square == piece.legal_squares.back() and square not in whiteCancelCheckSquares and piece == whitePieces.back():
						return false

					
