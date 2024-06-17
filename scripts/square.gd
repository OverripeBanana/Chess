extends Area2D

class_name Square

#variables
@onready var color_rect = $ColorRect
@onready var circle = $Circle
var protectedByBlack : bool = false
var protectedByWhite : bool = false
var originalColor
#variables
		
func _ready():
	originalColor = color_rect.color
	
#func _physics_process(delta):
	#if protectedByBlack and protectedByWhite:
		#color_rect.color = Color(0, 1, 0, 1)
	#elif protectedByBlack:
		#color_rect.color = Color(1, 0, 0, 1)
	#elif protectedByWhite:
		#color_rect.color = Color(0, 0, 1, 1)
	#else:
		#color_rect.color = originalColor


func legal():
	circle.show()
func illegal():
	circle.hide()

