extends Node

enum States {LEGAL, ILLEGAL}
enum WinStates {DEFAULT, BLACK_WIN, WHITE_WIN, STALEMATE}
var gameState : States = States.LEGAL
var winState : WinStates = WinStates.DEFAULT
var blackLeftCastle : bool = false
var blackRightCastle : bool = false
var whiteLeftCastle : bool = false
var whiteRightCastle : bool = false
var canBlackKingMove : bool = true
var canWhiteKingMove : bool = true

func _ready():
	TurnManager.blackTurnFinished.connect(_on_black_turn_finished)
	TurnManager.whiteTurnFinished.connect(_on_white_turn_finished)

#func _process(delta):
	#print(gameState)
	
func _on_black_turn_finished():
	#print(Check.blackInCheck)
	gameState = States.LEGAL
	await get_tree().create_timer(0.4).timeout
	if Check.blackInCheck:
		gameState = States.ILLEGAL
	else:
		gameState = States.LEGAL
	#print(gameState)

func _on_white_turn_finished():
	#print(Check.whiteInCheck)
	gameState = States.LEGAL
	await get_tree().create_timer(0.4).timeout
	if Check.whiteInCheck:
		gameState = States.ILLEGAL
	else:
		gameState = States.LEGAL
	#print(gameState)
