extends Area2D

#variables
@onready var rect : ColorRect = $ColorRect
@onready var circle = $Circle
enum SquareColor {BLACK, WHITE}
var myColor : SquareColor
var originalColor
#variables

func _ready():
	originalColor = rect.color
	
func _physics_process(_delta):
	var overlapping_areas = get_overlapping_areas()
	if len(overlapping_areas) > 0:
		for value in overlapping_areas:
			if value.collision_layer == 8:
				illegal()
				occupied()
				break
			else:
				legal()
				unoccupied()
	else:
		illegal()
	if collision_layer == 5:
		rect.color = Color(1, 0, 0, 1)	
	else:
		rect.color = originalColor
		
func legal():
	circle.show()
func illegal():
	circle.hide()
func occupied():
	set_collision_layer_value(3, true)

func unoccupied():
	set_collision_layer_value(3, false)
	
