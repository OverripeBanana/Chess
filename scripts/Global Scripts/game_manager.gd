extends Node

enum States {LEGAL, ILLEGAL, BLACK_WIN, WHITE_WIN, STALEMATE}
var gameState : States

func _ready():
	TurnManager.blackTurnFinished.connect(_on_black_turn_finished)
	TurnManager.whiteTurnFinished.connect(_on_white_turn_finished)


func _on_black_turn_finished():
	await get_tree().create_timer(0.1).timeout
	if Check.blackInCheck:
		gameState = States.ILLEGAL
	else:
		gameState = States.LEGAL

func _on_white_turn_finished():
	await get_tree().create_timer(0.1).timeout
	if Check.whiteInCheck:
		gameState = States.ILLEGAL
	else:
		gameState = States.LEGAL
	
