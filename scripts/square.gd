extends Area2D

#variables
@onready var rect : ColorRect = $ColorRect
@onready var circle = $Circle
#variables
		
func legal():
	circle.show()
func illegal():
	circle.hide()

