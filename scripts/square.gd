extends Area2D

class_name Square

#variables
@onready var circle = $Circle
var protected
#variables
		
func legal():
	circle.show()
func illegal():
	circle.hide()

