extends Node2D

@onready var black = $Black
@onready var white = $White

var blackPieces = []
var whitePieces = []

func _process(_delta):
	blackPieces = black.get_children()
	whitePieces = white.get_children()
	Check.blackPieces = blackPieces
	Check.whitePieces=  whitePieces
