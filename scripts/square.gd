extends Area2D

class_name Square

#variables
@onready var color_rect = $ColorRect
var protectedByBlack : bool = false
var protectedByWhite : bool = false
var occupied : bool = false
var protectors = []
var originalColor
#variables
		
func _ready():
	originalColor = color_rect.color

func _process(_delta):
	#showProtects()
	if Input.is_action_just_released("left_click"):
		protectors.clear()
		
func showProtects():
	if protectedByBlack and protectedByWhite:
		color_rect.color = Color(0, 1, 0, 1)
	elif protectedByBlack:
		color_rect.color = Color(1, 0, 0, 1)
	elif protectedByWhite:
		color_rect.color = Color(0, 0, 1, 1)
	else:
		color_rect.color = originalColor


