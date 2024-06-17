extends Area2D

class_name Square

#variables
@onready var circle = $Circle
var protected : ChessColor.chess_color
#variables
		
func legal():
	circle.show()
func illegal():
	circle.hide()

