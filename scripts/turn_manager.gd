extends Node

enum Turn {BLACK, WHITE}

var currentTurn : Turn

func _ready():
	currentTurn = Turn.WHITE

func switchTurn():
	if TurnManager.currentTurn == TurnManager.Turn.WHITE:
		TurnManager.currentTurn = TurnManager.Turn.BLACK
	elif TurnManager.currentTurn == TurnManager.Turn.BLACK:
		TurnManager.currentTurn = TurnManager.Turn.WHITE
