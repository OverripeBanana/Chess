extends Area2D

#variables
@onready var rect : ColorRect = $ColorRect
@onready var circle = $Circle
enum SquareColor {BLACK, WHITE}
var myColor : SquareColor
#variables

func _ready():
	if rect.color == Color(0, 0, 0):
		myColor = SquareColor.BLACK
	else:
		myColor = SquareColor.WHITE
	
func _physics_process(delta):
	var overlapping_areas = get_overlapping_areas()
	if len(overlapping_areas) > 0:
		for value in overlapping_areas:
			if value.collision_layer == 2:
				illegal()
				break
			else:
				legal()
	else:
		illegal()
		
func legal():
	circle.show()
func illegal():
	circle.hide()

