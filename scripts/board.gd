extends Node2D

#right white
@onready var white_square_23 = $"White Square23"
@onready var black_square_24 = $"Black Square24"
#left white
@onready var white_square_21 = $"White Square21"
@onready var black_square_22 = $"Black Square22"
@onready var white_square_33 = $"White Square33"
#right black
@onready var black_square = $"Black Square"
@onready var white_square_2 = $"White Square2"
@onready var black_square_2 = $"Black Square2"
#left black
@onready var black_square_3 = $"Black Square3"
@onready var white_square_4 = $"White Square4"



func _process(_delta):
	GameManager.whiteLeftCastle = white_square_21.occupied == 2 and black_square_22.occupied == 2 and white_square_33.occupied == 2
	GameManager.whiteRightCastle = white_square_23.occupied == 2 and black_square_24.occupied == 2
	
	GameManager.blackLeftCastle = black_square_3.occupied == 2 and white_square_4.occupied == 2
	GameManager.blackRightCastle = black_square.occupied == 2 and white_square_2.occupied == 2 and black_square_2.occupied == 2
